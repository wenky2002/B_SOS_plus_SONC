%% This is f7 in Table 1
clc; clear all;
pop.F = [4 2 1;
         2 4 1;
         0 0 1;
         2 2 -3];
pop.n = {1:2};

% variables in objective function
pop.I = {1:2};

% constraints
pop.G{1} = [1 0 1];
pop.G{2} = [0 1 1];
pop.J = {1:2}

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
