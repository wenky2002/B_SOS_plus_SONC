%% This is f9 in Table 1 by using bounded-SOS
yalmip('clear')
clc;clear all;

% objective function f  = 0.5(1+2xy+x^2y)^2 + m;
pop.F = [0 0 1.5;
         1 1 2;
         2 1 1;
         2 2 -1;
         3 2 2;
         4 2 1.5;
         2 4 1];
pop.n = 2;

% variables in objective function
pop.I = {1:2};

% constraints
pop.G{1} = [1 0 1];
pop.G{2} = [0 1 1];
pop.G{3} = [2 2 1];
pop.J = {1:3};


% initialize result container
results = struct('k', {}, 'obj', {});

% k and d
pop.k = 3;
pop.d = 4;

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
