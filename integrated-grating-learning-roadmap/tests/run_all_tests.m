function run_all_tests()
%RUN_ALL_TESTS Verification suite for the integrated grating package.

testDir = fileparts(mfilename('fullpath'));
rootDir = fileparts(testDir);
addpath(fullfile(rootDir, 'matlab'));

tests = {@test_uniform_center, @test_uniform_vs_nonuniform, ...
    @test_apodization, @test_multimode_single_mode_limit, ...
    @test_cross_mode_stopband, @test_vertical_gc};

fprintf('Running %d integrated-grating tests...\n', numel(tests));
for index = 1:numel(tests)
    feval(tests{index});
    fprintf('  PASS  %s\n', func2str(tests{index}));
end
fprintf('All tests passed.\n');
end

function test_uniform_center()
kappa = 2400;
lengthGrating = 1.2e-3;
frequency = [193.3e12,193.4e12,193.5e12];
[s11,s21,~,~,out] = grating.uniform_bg( ...
    kappa, [0,0,0], 0, lengthGrating, frequency);
expectedR = tanh(abs(kappa)*lengthGrating)^2;
assert(max(abs(abs(s11).^2-expectedR)) < 1e-12);
assert(max(abs(abs(s11).^2+abs(s21).^2-1)) < 1e-12);
assert(max(abs(out.powerResidual)) < 1e-12);
end

function test_uniform_vs_nonuniform()
c0 = 299792458;
f0 = 193.4e12;
frequency = linspace(f0-0.4e12,f0+0.4e12,81);
delta = 2*pi*1.9/c0*(frequency-f0);
kappa = 1800;
lengthGrating = 1.1e-3;
[r1,t1] = grating.uniform_bg(kappa,delta,0,lengthGrating,frequency);
z = linspace(0,lengthGrating,102);
deltaMatrix = repmat(delta,numel(z)-1,1);
[r2,t2] = grating.nonuniform_bg(z,kappa,deltaMatrix,0,frequency);
assert(max(abs(r1-r2)) < 1e-10);
assert(max(abs(t1-t2)) < 1e-10);
end

function test_apodization()
z = linspace(0,1,101);
uniform = grating.apodization_profile(z,'uniform');
gaussian = grating.apodization_profile(z,'gaussian');
raised = grating.apodization_profile(z,'raised-cosine');
assert(max(abs(uniform-1)) < eps);
assert(abs(max(gaussian)-1) < 10*eps);
assert(abs(raised(1)) < eps && abs(raised(end)) < eps);
end

function test_multimode_single_mode_limit()
kappa = 2100;
lengthGrating = 0.9e-3;
frequency = 193.4e12;
gratingK = 10e6;
beta = gratingK/2;
[rUniform,tUniform] = grating.uniform_bg( ...
    kappa,0,0,lengthGrating,frequency);
[rMulti,tMulti,loss,out] = grating.multimode_bg( ...
    beta,kappa,gratingK,[0,lengthGrating],frequency);
assert(abs(rUniform-rMulti(1,1,1)) < 1e-12);
assert(abs(tUniform-tMulti(1,1,1)) < 1e-12);
assert(abs(loss) < 1e-12);
assert(abs(out.powerBalance-1) < 1e-12);
end

function test_cross_mode_stopband()
c0 = 299792458;
n0 = 1.9;
n1 = 1.6;
fSelf = 200e12;
gratingK = 2*(2*pi*n0*fSelf/c0);
fCross = gratingK*c0/(2*pi*(n0+n1));
beta = [2*pi*n0*fCross/c0;2*pi*n1*fCross/c0];
lengthGrating = 2e-3;

[rOn,~,~,~] = grating.multimode_bg( ...
    beta,[0,800;800,0],gratingK,[0,lengthGrating],fCross);
[rOff,~,~,~] = grating.multimode_bg( ...
    beta,zeros(2),gratingK,[0,lengthGrating],fCross);
crossReflectionOn = abs(rOn(2,1,1))^2;
crossReflectionOff = abs(rOff(2,1,1))^2;
assert(crossReflectionOn > 0.5);
assert(crossReflectionOff < 1e-14);
end

function test_vertical_gc()
lambda0 = 1550e-9;
z = linspace(0,25e-6,401);
target.z = z;
target.amplitude = exp(-0.5*((z-12.5e-6)/4.5e-6).^2);
stack = struct('extractedPower',0.9,'directionality',0.8, ...
    'transitionEfficiency',0.95);
out = grating.vertical_gc(lambda0,1.8,1.44,0,target,stack);
assert(abs(out.period-lambda0/1.8) < 1e-15);
assert(abs(out.overlapEfficiency-1) < 1e-12);
assert(abs(out.totalEfficiency-0.9*0.8*0.95) < 1e-12);
assert(out.remainingPower(end) > 0.09 && out.remainingPower(end) < 0.11);
assert(out.verticalBackReflectionWarning);
end

