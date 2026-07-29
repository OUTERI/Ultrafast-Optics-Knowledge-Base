function design = uniform_design(lambda0, neff, ng, kappa, targetReflectivity)
%UNIFORM_DESIGN First-order design of a uniform integrated Bragg grating.
%   DESIGN = grating.uniform_design(LAMBDA0,NEFF,NG,KAPPA,TARGETR)
%   returns the first-order period, required length, and infinite-grating
%   stopband-width estimate.

validateattributes(lambda0, {'numeric'}, ...
    {'real','finite','scalar','positive'}, mfilename, 'lambda0');
validateattributes(neff, {'numeric'}, ...
    {'real','finite','scalar','positive'}, mfilename, 'neff');
validateattributes(ng, {'numeric'}, ...
    {'real','finite','scalar','positive'}, mfilename, 'ng');
validateattributes(kappa, {'numeric'}, ...
    {'finite','scalar','nonzero'}, mfilename, 'kappa');
validateattributes(targetReflectivity, {'numeric'}, ...
    {'real','finite','scalar','>',0,'<',1}, mfilename, 'targetReflectivity');

design = struct();
design.lambda0 = lambda0;
design.period = lambda0/(2*neff);
design.length = atanh(sqrt(targetReflectivity))/abs(kappa);
design.stopbandWidthWavelength = lambda0^2*abs(kappa)/(pi*ng);
design.stopbandWidthFrequency = 299792458*abs(kappa)/(pi*ng);
design.kappaLength = abs(kappa)*design.length;
design.targetReflectivity = targetReflectivity;
end

