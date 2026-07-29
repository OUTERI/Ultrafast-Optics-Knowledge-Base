% DAY05_UNIFORM_COMPARE Compare exact uniform CMT and segmented TMM.

exampleDir = fileparts(mfilename('fullpath'));
addpath(fullfile(fileparts(exampleDir), 'matlab'));

c0 = 299792458;
lambda0 = 1550e-9;
f0 = c0/lambda0;
frequency = linspace(f0-0.7e12, f0+0.7e12, 601);
ng = 1.92;
kappa = 2500;
lengthGrating = 1.5e-3;
detuning = 2*pi*ng/c0*(frequency-f0);

[rUniform,tUniform,phaseUniform,tauUniform,outUniform] = ...
    grating.uniform_bg(kappa, detuning, 0, lengthGrating, frequency);

z = linspace(0, lengthGrating, 301);
nSegment = numel(z)-1;
detuningMatrix = repmat(detuning, nSegment, 1);
[rTmm,tTmm,~,~,~,outTmm] = grating.nonuniform_bg( ...
    z, kappa, detuningMatrix, 0, frequency);

fprintf('Maximum reflectivity difference: %.3e\n', ...
    max(abs(abs(rUniform).^2-abs(rTmm).^2)));
fprintf('Maximum transmissivity difference: %.3e\n', ...
    max(abs(abs(tUniform).^2-abs(tTmm).^2)));
fprintf('Maximum lossless power residual: %.3e\n', ...
    max(abs(outUniform.powerResidual)));

wavelengthNm = c0./frequency*1e9;
figure('Color','w','Name','Day 05: uniform Bragg grating');
subplot(2,2,1);
plot(wavelengthNm, outUniform.reflectivity, 'LineWidth', 1.5); hold on;
plot(wavelengthNm, outTmm.reflectivity, '--', 'LineWidth', 1.0);
xlabel('Wavelength (nm)'); ylabel('Reflectivity'); grid on;
legend('Exact uniform matrix','Segmented TMM','Location','best');

subplot(2,2,2);
plot(wavelengthNm, outUniform.transmissivity, 'LineWidth', 1.5);
xlabel('Wavelength (nm)'); ylabel('Transmissivity'); grid on;

subplot(2,2,3);
plot(wavelengthNm, phaseUniform, 'LineWidth', 1.5);
xlabel('Wavelength (nm)'); ylabel('Reflection phase (rad)'); grid on;

subplot(2,2,4);
plot(wavelengthNm, tauUniform*1e12, 'LineWidth', 1.5);
xlabel('Wavelength (nm)'); ylabel('Group delay (ps)'); grid on;

