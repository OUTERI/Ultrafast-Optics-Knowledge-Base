% DAY17_CHIRPED_APODIZED Compare apodization profiles in a chirped BG.

exampleDir = fileparts(mfilename('fullpath'));
addpath(fullfile(fileparts(exampleDir), 'matlab'));

c0 = 299792458;
lambda0 = 1550e-9;
f0 = c0/lambda0;
frequency = linspace(f0-1.5e12, f0+1.5e12, 801);
ng = 1.92;
lengthGrating = 8e-3;
z = linspace(0, lengthGrating, 801);
zc = (z(1:end-1)+z(2:end))/2;
nSegment = numel(z)-1;

frequencyDetuning = 2*pi*ng/c0*(frequency-f0);
chirpSlope = 1.0e6; % detuning slope [1/m^2]
spatialDetuning = chirpSlope*(zc(:)-lengthGrating/2);
detuning = repmat(frequencyDetuning, nSegment, 1)- ...
    repmat(spatialDetuning, 1, numel(frequency));

profileNames = {'uniform','gaussian','tanh','raised-cosine'};
colors = lines(numel(profileNames));
targetIntegratedCoupling = 7.0;

figure('Color','w','Name','Day 17: chirped and apodized BG');
subplot(2,1,1); hold on;
subplot(2,1,2); hold on;

for index = 1:numel(profileNames)
    profile = grating.apodization_profile(zc, profileNames{index});
    scale = targetIntegratedCoupling/trapz(zc, profile);
    kappaZ = scale*profile;
    [r,~,~,tau,~,out] = grating.nonuniform_bg( ...
        z, kappaZ, detuning, 0, frequency);

    subplot(2,1,1);
    plot(c0./frequency*1e9, 10*log10(max(out.reflectivity,1e-12)), ...
        'Color', colors(index,:), 'LineWidth', 1.2);
    subplot(2,1,2);
    plot(c0./frequency*1e9, tau*1e12, ...
        'Color', colors(index,:), 'LineWidth', 1.2);
end

subplot(2,1,1);
xlabel('Wavelength (nm)'); ylabel('Reflection (dB)'); grid on;
legend(profileNames,'Location','best'); ylim([-60 1]);
subplot(2,1,2);
xlabel('Wavelength (nm)'); ylabel('Group delay (ps)'); grid on;
legend(profileNames,'Location','best');

fprintf(['Profiles are compared at equal integral coupling. Re-run with ' ...
    'equal peak kappa and equal center reflectivity to see how the fairness ' ...
    'constraint changes the conclusion.\n']);

