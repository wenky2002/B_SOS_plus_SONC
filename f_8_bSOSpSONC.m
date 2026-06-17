%% This is f8 in Table 1
clc; clear all;
yalmip('clear');

% decision variables 
sdpvar x y z
vecVar = [x y z];

% objective function        
Q = x^2*y^2 + x^2*z^2 + y^2*z^2 + 1 - 4*x*y*z;
f = (x*y + x*z + y*z)^2 + 1 + Q;

% constraint polynomials 
gList = {x,y,z,x^2+y^2+z^2};   

% relaxation orders 
k = 4;         % SOS half-degree 
d = 5;          % multiplier degree

% call bounded-SOS+SONC solver 
[val, diagnostics, fSOS, fSONC, hSOS, hSONC, lambdaOpt] =  boundedSOSplusSONC(f, gList, vecVar, k, d, 1);

% optimal value
val