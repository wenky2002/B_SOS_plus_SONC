%% This is f3 using B-SOS
% B-SOS
clc; clear all;
pop.F = [0 0 1;
         2 4 1;
         4 2 1;
         2 2 -1];
pop.n = 2;

% variables in objective function
pop.I = {1:2};

% constraints
pop.G{1} = [1 0 1];
pop.G{2} = [0 1 1];
pop.J = {1:2};


% initialize result container
results = struct('k', {}, 'obj', {});

% k and d
pop.k = 3;
pop.d = 8;

% solve BSOS
sdp = gendata2(pop,'BSOS');
sol = csol(sdp,'sqlp');
psol = postproc(pop,sdp,sol);

% optimal value

psol.obj
