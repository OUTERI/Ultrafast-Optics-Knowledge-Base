function setup()
%SETUP Add the learning package, examples, and tests to the MATLAB path.

rootDir = fileparts(mfilename('fullpath'));
addpath(fullfile(rootDir, 'matlab'));
addpath(fullfile(rootDir, 'examples'));
addpath(fullfile(rootDir, 'tests'));

fprintf('Integrated grating learning package added to the MATLAB path.\n');
fprintf('Run run_all_tests to verify the numerical models.\n');
end

