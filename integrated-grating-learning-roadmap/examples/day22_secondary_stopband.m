% DAY22_SECONDARY_STOPBAND Demonstrate a mode-coupling secondary stopband.

exampleDir = fileparts(mfilename('fullpath'));
addpath(fullfile(fileparts(exampleDir), 'matlab'));

c0 = 299792458;
frequency = linspace(190e12, 223e12, 1201);
neffMode0 = 1.90;
neffMode1 = 1.60;
betaModes = [2*pi*neffMode0*frequency/c0; ...
             2*pi*neffMode1*frequency/c0];

selfBraggFrequency = 200e12;
gratingK = 2*(2*pi*neffMode0*selfBraggFrequency/c0);
lengthGrating = 2.0e-3;
z = [0,lengthGrating];

couplingWithCrossMode = [1200,700;700,0];
[s11With,~,~,outWith] = grating.multimode_bg( ...
    betaModes, couplingWithCrossMode, gratingK, z, frequency);

couplingWithoutCrossMode = [1200,0;0,0];
[s11Without,~,~,outWithout] = grating.multimode_bg( ...
    betaModes, couplingWithoutCrossMode, gratingK, z, frequency);

reflectionWith = squeeze(sum(abs(s11With(:,1,:)).^2,1)).';
reflectionWithout = squeeze(sum(abs(s11Without(:,1,:)).^2,1)).';
crossModeReflection = squeeze(abs(s11With(2,1,:)).^2).';

predictedCrossFrequency = ...
    gratingK*c0/(2*pi*(neffMode0+neffMode1));
fprintf('Self-mode Bragg frequency: %.2f THz\n', selfBraggFrequency*1e-12);
fprintf('Cross-mode Bragg frequency: %.2f THz\n', predictedCrossFrequency*1e-12);
fprintf('Maximum lossless power error: %.3e\n', ...
    max(abs(outWith.powerBalance(1,:)-1)));

figure('Color','w','Name','Day 22: secondary stopband');
plot(frequency*1e-12, 10*log10(max(1-reflectionWith,1e-12)), ...
    'LineWidth', 1.5); hold on;
plot(frequency*1e-12, 10*log10(max(1-reflectionWithout,1e-12)), ...
    '--', 'LineWidth', 1.5);
plot(frequency*1e-12, 10*log10(max(1-crossModeReflection,1e-12)), ...
    ':', 'LineWidth', 1.2);
xlabel('Frequency (THz)'); ylabel('Power metric (dB)'); grid on;
legend('Total transmission proxy, cross coupling on', ...
    'Total transmission proxy, cross coupling off', ...
    '1 - reflected mode-1 power','Location','best');

