%% This is f10 
yalmip('clear');
clc;clear all;

% decision variables 
sdpvar x y 
vecVar = [x y];

% objective function       
m = x^4*y^2 + x^2*y^4 + 1 - 3*x^2*y^2
f = x^2 + m;

% constraint polynomials 
gList = {x y x^2+y^2};          

% relaxation orders 
k = 3;         % SOS half-degree 
d = 2;          % multiplier degree

% call bounded-SOS+SONC solver 
[val, diagnostics, fSOS, fSONC, hSOS, hSONC, lambdaOpt] =  boundedSOSplusSONC(f, gList, vecVar, k, d, 1)
