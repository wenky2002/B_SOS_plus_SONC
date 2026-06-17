%% This is f5 in Table 1

clc; clear all;
pop.F = [4 1;
         3 -6;
         2 13;
         1 -12;
         0 4];
pop.n = 1;

% variables in objective function
pop.I = {1};

% constraints
pop.G{1} = [1 1];
pop.J = {1};


% initialize result container
results = struct('k', {}, 'obj', {});

% k and d
pop.k = 2;
pop.d = 1;

% solve BSOS
sdp = gendata2(pop,'BSOS');
sol = csol(sdp,'sqlp');
psol = postproc(pop,sdp,sol);

% optimal value
psol.obj
