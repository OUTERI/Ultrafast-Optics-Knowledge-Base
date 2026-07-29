function [S11, S21, reflectionPhase, groupDelay, gdd, out] = ...
    nonuniform_bg(z, kappaZ, detuningZ, lossZ, frequency)
%NONUNIFORM_BG Piecewise-uniform transfer-matrix Bragg grating solver.
%   z must contain segment boundaries. Profiles may be scalar, one value
%   per segment, one value per z-node, one value per frequency, or an
%   Nsegment-by-Nfrequency matrix. Ambiguous vector dimensions should be
%   supplied explicitly as a matrix.

validateattributes(z, {'numeric'}, {'real','finite','vector'}, mfilename, 'z');
validateattributes(frequency, {'numeric'}, ...
    {'real','finite','vector','positive'}, mfilename, 'frequency');

z = z(:);
if numel(z) < 2 || any(diff(z) <= 0)
    error('grating:nonuniform_bg:InvalidZ', ...
        'z must contain at least two strictly increasing segment boundaries.');
end

frequency = frequency(:).';
nSegment = numel(z)-1;
nFrequency = numel(frequency);
dz = diff(z);

kappa = expand_profile(kappaZ, nSegment, nFrequency, 'kappaZ');
detuning = expand_profile(detuningZ, nSegment, nFrequency, 'detuningZ');
loss = expand_profile(lossZ, nSegment, nFrequency, 'lossZ');

if any(real(loss(:)) < 0) || any(abs(imag(loss(:))) > 0)
    error('grating:nonuniform_bg:InvalidLoss', ...
        'lossZ must be real and nonnegative.');
end

S11 = complex(zeros(1, nFrequency));
S21 = complex(zeros(1, nFrequency));

for frequencyIndex = 1:nFrequency
    totalMatrix = eye(2);
    for segmentIndex = 1:nSegment
        h = [1i*detuning(segmentIndex,frequencyIndex)-loss(segmentIndex,frequencyIndex)/2, ...
             1i*kappa(segmentIndex,frequencyIndex); ...
            -1i*conj(kappa(segmentIndex,frequencyIndex)), ...
            -1i*detuning(segmentIndex,frequencyIndex)+loss(segmentIndex,frequencyIndex)/2];
        segmentMatrix = expm(h*dz(segmentIndex));
        totalMatrix = segmentMatrix*totalMatrix;
    end

    if abs(totalMatrix(2,2)) < 100*eps
        error('grating:nonuniform_bg:SingularBoundary', ...
            'The boundary solve is singular at frequency index %d.', frequencyIndex);
    end

    S11(frequencyIndex) = -totalMatrix(2,1)/totalMatrix(2,2);
    S21(frequencyIndex) = det(totalMatrix)/totalMatrix(2,2);
end

[reflectionPhase, groupDelay, gdd] = ...
    grating.phase_metrics(S11, frequency);

out = struct();
out.reflectivity = abs(S11).^2;
out.transmissivity = abs(S21).^2;
out.powerResidual = 1-out.reflectivity-out.transmissivity;
out.kappa = kappa;
out.detuning = detuning;
out.loss = loss;
out.segmentCenters = (z(1:end-1)+z(2:end))/2;
end

function expanded = expand_profile(profile, nSegment, nFrequency, argumentName)
validateattributes(profile, {'numeric'}, {'finite'}, mfilename, argumentName);

if isscalar(profile)
    expanded = repmat(profile, nSegment, nFrequency);
    return;
end

if isvector(profile)
    count = numel(profile);
    possible = [count == nSegment, count == nSegment+1, count == nFrequency];
    if sum(possible) > 1
        error('grating:nonuniform_bg:AmbiguousProfile', ...
            ['%s has an ambiguous vector length. Supply an explicit ' ...
             'Nsegment-by-Nfrequency matrix.'], argumentName);
    elseif count == nSegment
        expanded = repmat(profile(:), 1, nFrequency);
    elseif count == nSegment+1
        nodeValues = profile(:);
        segmentValues = (nodeValues(1:end-1)+nodeValues(2:end))/2;
        expanded = repmat(segmentValues, 1, nFrequency);
    elseif count == nFrequency
        expanded = repmat(profile(:).', nSegment, 1);
    else
        error('grating:nonuniform_bg:SizeMismatch', ...
            '%s has an unsupported vector length.', argumentName);
    end
    return;
end

if isequal(size(profile), [nSegment,nFrequency])
    expanded = profile;
elseif isequal(size(profile), [nSegment+1,nFrequency])
    expanded = (profile(1:end-1,:)+profile(2:end,:))/2;
else
    error('grating:nonuniform_bg:SizeMismatch', ...
        '%s must be scalar, a supported vector, or Nsegment-by-Nfrequency.', ...
        argumentName);
end
end

