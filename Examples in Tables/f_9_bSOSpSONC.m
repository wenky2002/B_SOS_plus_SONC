%% This is f9 in Table 1 by using Bounded-SOS+SONC
yalmip('clear')
clc;clear all;

% decision variables 
sdpvar x y
vecVar = [x y];

% objective function        
m = x^4*y^2 + x^2*y^4 + 1 - 3*x^2*y^2;
f = 0.5*(1 + 2*x*y + x^2*y)^2 + m;

% constraint polynomials 
gList = {x,y,x^2+y^2};          % g1 = x ,   g2 = y

% relaxation orders 
k = 3;         % SOS half-degree   (2k = 6)
d = 4;          % multiplier degree

% total timing start 
t_total = tic;

% call bounded-SOS+SONC solver 
[val, diagnostics, fSOS, fSONC, hSOS, hSONC, lambdaOpt] =  boundedMinSOSpSONC(f, gList, vecVar, k, d, 1);

% total timing end 
total_time = toc(t_total);
fprintf('TOTAL time: %.6f s\n', total_time);

% optimal value
val