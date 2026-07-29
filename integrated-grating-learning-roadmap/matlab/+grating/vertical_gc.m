function out = vertical_gc(lambda, neff, nclad, theta, targetField, stack)
%VERTICAL_GC Analytical initial design of a vertical grating coupler.
%   OUT = grating.vertical_gc(LAMBDA,NEFF,NCLAD,THETA,TARGETFIELD,STACK)
%
%   TARGETFIELD fields:
%     z         strictly increasing longitudinal coordinates [m]
%     amplitude desired complex radiation amplitude on z
%
%   STACK optional fields:
%     diffractionOrder     default 1
%     extractedPower       default 0.95
%     directionality       default 0.50 (symmetric first estimate)
%     transitionEfficiency default 1.00
%
%   THETA is in radians. The returned period is the local phase-matching
%   estimate; a leakage-Bloch-mode calculation is required for final design.

validateattributes(lambda, {'numeric'}, ...
    {'real','finite','vector','positive'}, mfilename, 'lambda');
validateattributes(neff, {'numeric'}, ...
    {'real','finite','vector','positive'}, mfilename, 'neff');
validateattributes(nclad, {'numeric'}, ...
    {'real','finite','scalar','positive'}, mfilename, 'nclad');
validateattributes(theta, {'numeric'}, ...
    {'real','finite','scalar'}, mfilename, 'theta');

if nargin < 6 || isempty(stack)
    stack = struct();
end
if ~isstruct(targetField) || ~isfield(targetField,'z') || ...
        ~isfield(targetField,'amplitude')
    error('grating:vertical_gc:InvalidTarget', ...
        'targetField must contain z and amplitude fields.');
end

z = targetField.z(:);
amplitude = targetField.amplitude(:);
if numel(z) ~= numel(amplitude) || numel(z) < 3 || any(diff(z) <= 0)
    error('grating:vertical_gc:TargetSizeMismatch', ...
        'targetField.z and amplitude must match and z must increase.');
end

lambda = lambda(:).';
if isscalar(neff)
    neff = repmat(neff, size(lambda));
elseif numel(neff) == numel(lambda)
    neff = neff(:).';
else
    error('grating:vertical_gc:NeffSizeMismatch', ...
        'neff must be scalar or contain one value per wavelength.');
end

order = field_or(stack, 'diffractionOrder', 1);
extractedPower = field_or(stack, 'extractedPower', 0.95);
directionality = field_or(stack, 'directionality', 0.50);
transitionEfficiency = field_or(stack, 'transitionEfficiency', 1.00);

validateattributes(order, {'numeric'}, {'real','finite','scalar','nonzero'}, ...
    mfilename, 'stack.diffractionOrder');
validate_probability(extractedPower, 'stack.extractedPower');
validate_probability(directionality, 'stack.directionality');
validate_probability(transitionEfficiency, 'stack.transitionEfficiency');

denominator = neff-nclad*sin(theta);
period = order*lambda./denominator;
if any(period <= 0)
    error('grating:vertical_gc:InvalidPeriod', ...
        'The selected angle/order convention produces a nonpositive period.');
end

targetPower = abs(amplitude).^2;
normalization = trapz(z, targetPower);
if normalization <= 0
    error('grating:vertical_gc:ZeroTarget', ...
        'The target field carries zero longitudinal power.');
end
targetPower = targetPower/normalization;
desiredRadiationDensity = extractedPower*targetPower;
extractedToZ = cumtrapz(z, desiredRadiationDensity);
remainingPower = 1-extractedToZ;

if any(remainingPower <= 0)
    error('grating:vertical_gc:ExhaustedPower', ...
        'The requested target extracts all power before the final point.');
end

radiationStrength = desiredRadiationDensity./(2*remainingPower);
radiatedAmplitude = sqrt(desiredRadiationDensity).*exp(1i*angle(amplitude));
overlapNumerator = abs(trapz(z, radiatedAmplitude.*conj(amplitude)))^2;
overlapDenominator = trapz(z, abs(radiatedAmplitude).^2)* ...
    trapz(z, abs(amplitude).^2);
overlapEfficiency = overlapNumerator/overlapDenominator;

out = struct();
out.period = period;
out.z = z;
out.radiationStrength = radiationStrength;
out.remainingPower = remainingPower;
out.radiatedAmplitude = radiatedAmplitude;
out.extractedPower = extractedPower;
out.directionality = directionality;
out.overlapEfficiency = min(1, real(overlapEfficiency));
out.transitionEfficiency = transitionEfficiency;
out.totalEfficiency = extractedPower*directionality* ...
    out.overlapEfficiency*transitionEfficiency;
out.couplingLength = z(end)-z(1);
out.verticalBackReflectionWarning = abs(theta) < pi/180;
out.notes = ['Period uses phase matching with supplied neff. Map the ' ...
    'radiation-strength profile to geometry using RCWA/FDTD/FEM calibration.'];
end

function value = field_or(inputStruct, fieldName, defaultValue)
if isfield(inputStruct, fieldName)
    value = inputStruct.(fieldName);
else
    value = defaultValue;
end
end

function validate_probability(value, argumentName)
validateattributes(value, {'numeric'}, ...
    {'real','finite','scalar','>=',0,'<=',1}, mfilename, argumentName);
end

