% DAY10_SIN_LNOI_DESIGN First-order SiN and LNOI uniform BG designs.

exampleDir = fileparts(mfilename('fullpath'));
addpath(fullfile(fileparts(exampleDir), 'matlab'));

lambda0 = 1550e-9;
targetReflectivity = 0.99;

sinDesign = grating.uniform_design(lambda0, 1.75, 1.92, 2500, targetReflectivity);
lnoiDesign = grating.uniform_design(lambda0, 2.05, 2.18, 4000, targetReflectivity);

fprintf('SiN first-order design\n');
fprintf('  period             = %.2f nm\n', sinDesign.period*1e9);
fprintf('  length for R=0.99  = %.3f mm\n', sinDesign.length*1e3);
fprintf('  stopband estimate  = %.2f nm\n', sinDesign.stopbandWidthWavelength*1e9);

fprintf('LNOI first-order design\n');
fprintf('  period             = %.2f nm\n', lnoiDesign.period*1e9);
fprintf('  length for R=0.99  = %.3f mm\n', lnoiDesign.length*1e3);
fprintf('  stopband estimate  = %.2f nm\n', lnoiDesign.stopbandWidthWavelength*1e9);

periodError = linspace(-2e-9, 2e-9, 101);
sinBragg = 2*1.75*(sinDesign.period+periodError);
lnoiBragg = 2*2.05*(lnoiDesign.period+periodError);

figure('Color','w','Name','Day 10: period tolerance');
plot(periodError*1e9, (sinBragg-lambda0)*1e9, 'LineWidth', 1.5); hold on;
plot(periodError*1e9, (lnoiBragg-lambda0)*1e9, 'LineWidth', 1.5);
xlabel('Period error (nm)'); ylabel('Bragg wavelength shift (nm)');
legend('SiN illustrative mode','LNOI illustrative mode','Location','best');
grid on;

fprintf(['The neff and kappa values are illustrative starting values. ' ...
    'Replace them with power-normalized eigenmode results before fabrication.\n']);

