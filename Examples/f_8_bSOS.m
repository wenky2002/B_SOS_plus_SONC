%% This is f8 in Table 1
clc; clear all;
yalmip('clear')
% define the objective function
pop.F = [2 2 0 2;
         2 0 2 2;
         0 2 2 2;
         2 1 1 2;
         1 2 1 2;
         1 1 2 2;
         1 1 1 -4;
         0 0 0 2];
         
% numbers of variables 
pop.n = 3;

% variables in objective function
pop.I = {1:3};

% constraints
pop.G{1} = [1 0 0 1];
pop.G{2} = [0 1 0 1];
pop.G{3} = [0 0 1 1];
pop.G{4} = [2 2 2 1];
pop.J = {1:4};

% k and d
pop.k = 2;
pop.d = 5;

% total timing start 
t_total = tic;

% solve BSOS
sdp = gendata2(pop,'BSOS');
sol = csol(sdp,'sqlp');
psol = postproc(pop,sdp,sol);

% total timing end 
total_time = toc(t_total);
fprintf('TOTAL time: %.6f s\n', total_time);

% optimal value
psol.obj
