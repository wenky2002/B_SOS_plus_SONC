%% This is f12 in Table 1 by using bounded-SOS+SONC
clc; clear all;
yalmip('clear');

% decision variables 
sdpvar x y z
vecVar = [x y z];

% objective function = m(x,y)       
f  = x^4*y^2 + x^2*y^4 + 1 - 3*x^2*y^2;

% constraint polynomials 
gList = {x,y,x^2+y^2};          

% relaxation orders 
k = 3;         % SOS half-degree   (2k = 6)
d = 3;          % multiplier degree

% total timing start 
t_total = tic;

% call bounded-SOS+SONC solver 
[val, diagnostics, fSOS, fSONC, hSOS, hSONC, lambdaOpt] =  boundedMinSOSpSONC(f, gList, vecVar, k, d, 1);

% total timing end 
total_time = toc(t_total);
fprintf('TOTAL time: %.6f s\n', total_time);

% optimal value
val