function [S11, S21, radiationLoss, out] = ...
    multimode_bg(betaModes, couplingMatrix, gratingK, z, frequency, varargin)
%MULTIMODE_BG Uniform multimode contra-directional coupled-mode solver.
%   [S11,S21,LOSS,OUT] = grating.multimode_bg(BETA,KAPPA,K,Z,F)
%   returns full mode-resolved reflection and transmission matrices.
%
%   BETA is Nmode-by-Nfrequency [1/m]. A single column is expanded over F.
%   KAPPA is an Nmode-by-Nmode coupling matrix [1/m].
%   gratingK is scalar or one value per frequency [1/m].
%   z contains the start and end coordinates; only total length is used.
%
%   Name-value option:
%     'ModeLoss' : scalar, Nmode vector, or Nmode-by-Nfrequency power loss.
%
%   S11(reflected mode, incident mode, frequency)
%   S21(transmitted mode, incident mode, frequency)

validateattributes(frequency, {'numeric'}, ...
    {'real','finite','vector','positive'}, mfilename, 'frequency');
validateattributes(z, {'numeric'}, {'real','finite','vector'}, mfilename, 'z');
validateattributes(betaModes, {'numeric'}, {'finite','2d'}, mfilename, 'betaModes');
validateattributes(couplingMatrix, {'numeric'}, {'finite','2d'}, ...
    mfilename, 'couplingMatrix');

z = z(:);
if numel(z) < 2 || any(diff(z) <= 0)
    error('grating:multimode_bg:InvalidZ', ...
        'z must contain strictly increasing coordinates.');
end
lengthGrating = z(end)-z(1);

frequency = frequency(:).';
nFrequency = numel(frequency);

if isvector(betaModes)
    betaModes = betaModes(:);
end
nMode = size(betaModes,1);
if size(betaModes,2) == 1
    betaModes = repmat(betaModes, 1, nFrequency);
elseif size(betaModes,2) ~= nFrequency
    error('grating:multimode_bg:BetaSizeMismatch', ...
        'betaModes must have one column or one column per frequency.');
end

if ~isequal(size(couplingMatrix), [nMode,nMode])
    error('grating:multimode_bg:CouplingSizeMismatch', ...
        'couplingMatrix must be Nmode-by-Nmode.');
end

gratingK = expand_frequency_vector(gratingK, nFrequency, 'gratingK');

parser = inputParser;
parser.addParameter('ModeLoss', 0, @isnumeric);
parser.parse(varargin{:});
modeLoss = expand_mode_frequency(parser.Results.ModeLoss, nMode, nFrequency);
if any(real(modeLoss(:)) < 0) || any(abs(imag(modeLoss(:))) > 0)
    error('grating:multimode_bg:InvalidLoss', ...
        'ModeLoss must be real and nonnegative.');
end

S11 = complex(zeros(nMode, nMode, nFrequency));
S21 = complex(zeros(nMode, nMode, nFrequency));
radiationLoss = zeros(nMode, nFrequency);
conditionM22 = zeros(1, nFrequency);

for frequencyIndex = 1:nFrequency
    detuning = betaModes(:,frequencyIndex)-gratingK(frequencyIndex)/2;
    attenuation = diag(modeLoss(:,frequencyIndex)/2);
    d = diag(detuning);

    h = [1i*d-attenuation, 1i*couplingMatrix; ...
        -1i*couplingMatrix', -1i*d+attenuation];
    transfer = expm(h*lengthGrating);

    m11 = transfer(1:nMode,1:nMode);
    m12 = transfer(1:nMode,nMode+1:end);
    m21 = transfer(nMode+1:end,1:nMode);
    m22 = transfer(nMode+1:end,nMode+1:end);
    conditionM22(frequencyIndex) = rcond(m22);
    if conditionM22(frequencyIndex) < 1e-13
        error('grating:multimode_bg:IllConditionedBoundary', ...
            'The backward boundary block is ill-conditioned at index %d.', ...
            frequencyIndex);
    end

    reflection = -(m22\m21);
    transmission = m11+m12*reflection;
    S11(:,:,frequencyIndex) = reflection;
    S21(:,:,frequencyIndex) = transmission;

    reflectedPower = sum(abs(reflection).^2, 1);
    transmittedPower = sum(abs(transmission).^2, 1);
    radiationLoss(:,frequencyIndex) = ...
        max(0, 1-reflectedPower-transmittedPower).';
end

out = struct();
out.reflectivityByMode = abs(S11).^2;
out.transmissivityByMode = abs(S21).^2;
out.totalReflectivity = reshape(sum(abs(S11).^2,1), nMode, nFrequency);
out.totalTransmissivity = reshape(sum(abs(S21).^2,1), nMode, nFrequency);
out.powerBalance = out.totalReflectivity+out.totalTransmissivity+radition_shape(radiationLoss);
out.detuning = betaModes-gratingK/2;
out.conditionM22 = conditionM22;
out.phaseMatchingSelf = 2*betaModes-gratingK;
out.convention = 'rows are output modes; columns are incident forward modes';
end

function value = expand_frequency_vector(value, nFrequency, argumentName)
validateattributes(value, {'numeric'}, {'real','finite','vector'}, mfilename, argumentName);
if isscalar(value)
    value = repmat(value, 1, nFrequency);
elseif numel(value) == nFrequency
    value = value(:).';
else
    error('grating:multimode_bg:FrequencySizeMismatch', ...
        '%s must be scalar or contain one value per frequency.', argumentName);
end
end

function value = expand_mode_frequency(value, nMode, nFrequency)
validateattributes(value, {'numeric'}, {'finite'}, mfilename, 'ModeLoss');
if isscalar(value)
    value = repmat(value, nMode, nFrequency);
elseif isvector(value) && numel(value) == nMode
    value = repmat(value(:), 1, nFrequency);
elseif isequal(size(value), [nMode,nFrequency])
    % Already in the required form.
else
    error('grating:multimode_bg:LossSizeMismatch', ...
        'ModeLoss must be scalar, Nmode, or Nmode-by-Nfrequency.');
end
end

function value = radition_shape(value)
% Keep the output dimensions explicit for old MATLAB/Octave releases.
value = reshape(value, size(value,1), size(value,2));
end

