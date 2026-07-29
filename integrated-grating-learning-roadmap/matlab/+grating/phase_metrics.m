function [phase, groupDelay, gdd] = phase_metrics(response, frequency)
%PHASE_METRICS Continuous phase, group delay, and GDD of a response.
%   [PHASE, TAU, GDD] = grating.phase_metrics(RESPONSE, FREQUENCY)
%   uses the package convention TAU = -d(PHASE)/d(omega).

validateattributes(response, {'numeric'}, {'vector'}, mfilename, 'response');
validateattributes(frequency, {'numeric'}, {'real','finite','vector','positive'}, ...
    mfilename, 'frequency');

originalSize = size(response);
response = response(:).';
frequency = frequency(:).';

if numel(response) ~= numel(frequency)
    error('grating:phase_metrics:SizeMismatch', ...
        'response and frequency must contain the same number of samples.');
end

phase = unwrap(angle(response));
if numel(frequency) < 2
    groupDelay = nan(size(phase));
    gdd = nan(size(phase));
else
    if any(diff(frequency) <= 0)
        error('grating:phase_metrics:FrequencyOrder', ...
            'frequency must be strictly increasing.');
    end
    omega = 2*pi*frequency;
    groupDelay = -gradient(phase, omega);
    gdd = gradient(groupDelay, omega);
end

phase = reshape(phase, originalSize);
groupDelay = reshape(groupDelay, originalSize);
gdd = reshape(gdd, originalSize);
end

