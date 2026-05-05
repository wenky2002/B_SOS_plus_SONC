%% This is f2 in Table 1 by using bounded-SOS
yalmip('clear');

% objective function f2 = X4Y2 + X2Y4 + Z6 − 3X2Y2Z2   
pop.F = [4 2 0 1;
         2 4 0 1;
         0 0 6 1;
         2 2 2 -3];
pop.n = 3;

% variables in objective function
pop.I = {1:3};

% constraints
pop.G{1} = [1 0 0 1];
pop.G{2} = [0 1 0 1];
pop.G{3} = [0 0 1 1];
pop.G{4} = [2 2 2 1];
pop.J = {1:4};


% initialize result container
results = struct('k', {}, 'obj', {});

% k and d
pop.k = 3;
pop.d =6;

% solve BSOS
sdp = gendata2(pop,'BSOS');
sol = csol(sdp,'sqlp');
psol = postproc(pop,sdp,sol);

% optimal value
psol.obj