function profile = apodization_profile(z, profileType, varargin)
%APODIZATION_PROFILE Normalized symmetric apodization profiles.
%   PROFILE = grating.apodization_profile(Z,TYPE) supports:
%   uniform, gaussian, tanh, raised-cosine, and sinc.

validateattributes(z, {'numeric'}, {'real','finite','vector'}, mfilename, 'z');
if numel(z) < 2 || max(z) == min(z)
    error('grating:apodization_profile:InvalidZ', ...
        'z must span a nonzero interval.');
end

parser = inputParser;
parser.addParameter('Sigma', 0.22, @(x) isnumeric(x) && isscalar(x) && x > 0);
parser.addParameter('Steepness', 8, @(x) isnumeric(x) && isscalar(x) && x > 0);
parser.addParameter('Lobes', 2, @(x) isnumeric(x) && isscalar(x) && x > 0);
parser.parse(varargin{:});

originalSize = size(z);
x = (z(:)-min(z))/(max(z)-min(z));
name = lower(char(profileType));

switch name
    case 'uniform'
        profile = ones(size(x));
    case 'gaussian'
        profile = exp(-0.5*((x-0.5)/parser.Results.Sigma).^2);
    case 'tanh'
        a = parser.Results.Steepness;
        profile = tanh(a*x).*tanh(a*(1-x));
    case {'raised-cosine','raised_cosine','cosine'}
        profile = 0.5*(1-cos(2*pi*x));
    case 'sinc'
        argument = parser.Results.Lobes*(x-0.5);
        profile = ones(size(argument));
        nonzero = abs(argument) > sqrt(eps);
        profile(nonzero) = sin(pi*argument(nonzero))./(pi*argument(nonzero));
        profile = abs(profile);
    otherwise
        error('grating:apodization_profile:UnknownType', ...
            'Unknown profile type: %s.', name);
end

maximum = max(abs(profile));
if maximum == 0
    error('grating:apodization_profile:ZeroProfile', ...
        'The requested profile is identically zero.');
end
profile = reshape(profile/maximum, originalSize);
end

