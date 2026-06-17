%% This is f11 in Table 1 by using Bounded-SOS+SONC
yalmip('clear');

% decision variables 
sdpvar x y z
vecVar = [x y z];

% objective function        
Q = x^2*y^2 + x^2*z^2 + y^2*z^2 + 1 - 4*x*y*z;

% constraint polynomials 
gList = {x,y,z};        

% relaxation orders 
k = 2;         % SOS half-degree 
d = 2;          % multiplier degree

% total timing start 
t_total = tic;

% call bounded-SOS+SONC solver 
[val, diagnostics, fSOS, fSONC, hSOS, hSONC, lambdaOpt] =  boundedSOSplusSONC(Q, gList, vecVar, k, d, 1);

% total timing end 
total_time = toc(t_total);
fprintf('TOTAL time: %.6f s\n', total_time);

% optimal value
val