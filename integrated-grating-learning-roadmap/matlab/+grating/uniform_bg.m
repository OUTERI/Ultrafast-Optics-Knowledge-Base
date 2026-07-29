function [S11, S21, reflectionPhase, groupDelay, out] = ...
    uniform_bg(kappa, delta, loss, lengthGrating, frequency)
%UNIFORM_BG Uniform contra-directional Bragg grating by exact CMT matrix.
%   [S11,S21,PHASE,TAU,OUT] = grating.uniform_bg(KAPPA,DELTA,LOSS,L,F)
%   solves a uniform two-mode grating with A(0)=1 and B(L)=0.
%
%   KAPPA : complex amplitude coupling coefficient [1/m]
%   DELTA : beta-K/2 detuning [1/m]
%   LOSS  : power attenuation coefficient [1/m]
%   L     : grating length [m]
%   F     : optical frequency [Hz]
%
%   Scalar KAPPA, DELTA, or LOSS is expanded over F. Vector inputs must
%   have the same number of elements as F.

validateattributes(lengthGrating, {'numeric'}, ...
    {'real','finite','scalar','positive'}, mfilename, 'lengthGrating');
validateattributes(frequency, {'numeric'}, ...
    {'real','finite','vector','positive'}, mfilename, 'frequency');

frequency = frequency(:).';
nFrequency = numel(frequency);
kappa = expand_vector(kappa, nFrequency, 'kappa');
delta = expand_vector(delta, nFrequency, 'delta');
loss = expand_vector(loss, nFrequency, 'loss');

if any(real(loss) < 0) || any(abs(imag(loss)) > 0)
    error('grating:uniform_bg:InvalidLoss', ...
        'loss must be a real, nonnegative power attenuation coefficient.');
end

S11 = complex(zeros(1, nFrequency));
S21 = complex(zeros(1, nFrequency));
transferMatrices = complex(zeros(2, 2, nFrequency));

for index = 1:nFrequency
    h = [1i*delta(index)-loss(index)/2, 1i*kappa(index); ...
        -1i*conj(kappa(index)), -1i*delta(index)+loss(index)/2];
    matrix = expm(h*lengthGrating);
    transferMatrices(:,:,index) = matrix;

    if abs(matrix(2,2)) < 100*eps
        error('grating:uniform_bg:SingularBoundary', ...
            'The boundary solve is singular at frequency index %d.', index);
    end

    S11(index) = -matrix(2,1)/matrix(2,2);
    S21(index) = det(matrix)/matrix(2,2);
end

[reflectionPhase, groupDelay, gdd] = ...
    grating.phase_metrics(S11, frequency);

out = struct();
out.reflectivity = abs(S11).^2;
out.transmissivity = abs(S21).^2;
out.powerResidual = 1-out.reflectivity-out.transmissivity;
out.gdd = gdd;
out.transferMatrices = transferMatrices;
out.convention = 'exp(-i*omega*t), delta=beta-K/2, loss is power loss';
end

function value = expand_vector(value, targetLength, argumentName)
validateattributes(value, {'numeric'}, {'finite','vector'}, mfilename, argumentName);
if isscalar(value)
    value = repmat(value, 1, targetLength);
elseif numel(value) == targetLength
    value = value(:).';
else
    error('grating:uniform_bg:SizeMismatch', ...
        '%s must be scalar or contain one value per frequency.', argumentName);
end
end

