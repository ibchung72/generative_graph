startup
%test_syngrid

% mpc = syngrid(200);
% pf_results = rundcpf(mpc);
% opf_results = rundcopf(mpc);

sgopt = sg_options('verbose', 0, 'bm.loading', 'D', 'bm.br2b_ratio', 2.5);
mpc = syngrid(200, sgopt, 'case_200sg');
pf_results = rundcpf(mpc);

% if creating a number of dataset for a determined number of nodes:
if not(isfolder('dataset'))
    mkdir('dataset')
end
location = './dataset';

IN = 1000; % number of grids to generate
N = 120; % number of nodes (buses)

for i = 1 : IN
    filename = ['n', num2str(N), '_', num2str(i), '_'];
    sgopt = sg_options('verbose', 0, 'bm.loading', 'D');
    mpc = syngrid(N, sgopt);
    pf_results = rundcpf(mpc);
    % save bus, branch, and gen
    writematrix(pf_results.bus, fullfile(location, [filename, 'bus.csv']))
    writematrix(pf_results.branch, fullfile(location, [filename, 'branch.csv']))
    writematrix(pf_results.gen, fullfile(location, [filename, 'gen.csv']))
end