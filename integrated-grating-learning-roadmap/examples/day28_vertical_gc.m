% DAY28_VERTICAL_GC Analytical SiN and LNOI vertical grating initial design.

exampleDir = fileparts(mfilename('fullpath'));
addpath(fullfile(fileparts(exampleDir), 'matlab'));

lambda0 = 1550e-9;
nclad = 1.44;
theta = 0;
z = linspace(0, 25e-6, 501);
waistZ = 4.5e-6;
targetField.z = z;
targetField.amplitude = exp(-0.5*((z-12.5e-6)/waistZ).^2);

sinStack = struct('extractedPower',0.95, ...
    'directionality',0.75,'transitionEfficiency',0.97);
lnoiStack = struct('extractedPower',0.95, ...
    'directionality',0.55,'transitionEfficiency',0.97);

sinResult = grating.vertical_gc( ...
    lambda0, 1.72, nclad, theta, targetField, sinStack);
lnoiResult = grating.vertical_gc( ...
    lambda0, 2.05, nclad, theta, targetField, lnoiStack);

fprintf('SiN vertical period estimate: %.1f nm\n', sinResult.period*1e9);
fprintf('SiN efficiency budget: %.1f %%\n', 100*sinResult.totalEfficiency);
fprintf('LNOI vertical period estimate: %.1f nm\n', lnoiResult.period*1e9);
fprintf('LNOI efficiency budget: %.1f %%\n', 100*lnoiResult.totalEfficiency);
fprintf(['Directionality values are explicit assumptions, not predictions. ' ...
    'Replace them with a multilayer Bloch/RCWA/FDTD result.\n']);

figure('Color','w','Name','Day 28: vertical grating coupler');
subplot(2,1,1);
plot(z*1e6, sinResult.radiationStrength, 'LineWidth', 1.5);
xlabel('z (um)'); ylabel('Radiation strength (1/m)'); grid on;
title('Required local radiation strength');
subplot(2,1,2);
plot(z*1e6, sinResult.remainingPower, 'LineWidth', 1.5); hold on;
plot(z*1e6, abs(sinResult.radiatedAmplitude).^2/max(abs(sinResult.radiatedAmplitude).^2), ...
    '--', 'LineWidth', 1.5);
xlabel('z (um)'); ylabel('Normalized power'); grid on;
legend('Remaining guided power','Radiated target density','Location','best');

