function kappa = coupling_overlap(lambda0, deltaEpsilonR, modeForward, ...
    modeBackward, areaWeights, powerForward, powerBackward)
%COUPLING_OVERLAP Vector-field perturbation overlap estimate for kappa.
%   The last array dimension of each mode field stores vector components.
%   deltaEpsilonR is relative-permittivity perturbation and areaWeights
%   contains the integration weights [m^2]. Pass the physically defined
%   backward-mode field for contra-directional coupling.

validateattributes(lambda0, {'numeric'}, ...
    {'real','finite','scalar','positive'}, mfilename, 'lambda0');
validateattributes(powerForward, {'numeric'}, ...
    {'real','finite','scalar','positive'}, mfilename, 'powerForward');
validateattributes(powerBackward, {'numeric'}, ...
    {'real','finite','scalar','positive'}, mfilename, 'powerBackward');

if ~isequal(size(modeForward), size(modeBackward))
    error('grating:coupling_overlap:ModeSizeMismatch', ...
        'Forward and backward mode fields must have the same size.');
end

componentDimension = ndims(modeForward);
fieldProduct = sum(conj(modeForward).*modeBackward, componentDimension);

if ~isequal(size(deltaEpsilonR), size(fieldProduct)) || ...
        ~isequal(size(areaWeights), size(fieldProduct))
    error('grating:coupling_overlap:GridSizeMismatch', ...
        ['deltaEpsilonR and areaWeights must match the field grid after ' ...
         'the vector-component dimension is summed.']);
end

epsilon0 = 8.8541878128e-12;
c0 = 299792458;
omega0 = 2*pi*c0/lambda0;
integralValue = sum(deltaEpsilonR(:).*fieldProduct(:).*areaWeights(:));
kappa = omega0*epsilon0*integralValue/ ...
    (4*sqrt(powerForward*powerBackward));
end

