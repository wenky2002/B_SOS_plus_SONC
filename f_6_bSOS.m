%% This is f6 in Table 1
yalmip('clear')
clc; clear all;
pop.F = [4 0 0 1;
         0 4 0 1;
         0 0 4 1;
         2 2 0 1;
         2 0 2 1;
         0 2 2 1;
         2 0 0 -2;
         0 2 0 -2;
         0 0 2 -2;
         1 1 1 -4;
         0 0 0 4];
pop.n = {1:3};

% variables in objective function
pop.I = {1:3};

% constraints
pop.G{1} = [1 0 0 1];
pop.G{2} = [0 1 0 1];
pop.G{3} = [0 0 1 1];
pop.J = {1:3}

% initialize result container
results = struct('k', {}, 'obj', {});

% k and d
pop.k = 3;
pop.d = 3;

% solve BSOS
sdp = gendata2(pop,'BSOS');
sol = csol(sdp,'sqlp');
psol = postproc(pop,sdp,sol);

% optimal value
psol.obj
