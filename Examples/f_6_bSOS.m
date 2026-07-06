%% This is f11 in Table1 by using Bounded-SOS
% define the objective function
pop.F = [2 2 0 1;
         2 0 2 1;
         0 2 2 1;
         1 1 1 -4;
         0 0 0 1];
pop.n = 3;

% variables in objective function
pop.I = {1:3};

% constraints
pop.G{1} = [1 0 0 1];
pop.G{2} = [0 1 0 1];
pop.G{3} = [0 0 1 1];
pop.J = {1:3};

% initialize result container
results = struct('k', {}, 'obj', {});

% k and d
pop.k = 2;
pop.d = 3;

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
