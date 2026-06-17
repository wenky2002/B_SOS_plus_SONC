%% This is f2 in Table 1 by using bounded-SOS+SONC
clc; clear all;
yalmip('clear');

% decision variables 
sdpvar x y z
vecVar = [x y z];

% objective function = X4Y2 + X2Y4 + Z6 − 3X2Y2Z2         
f  = x^4*y^2 + x^2*y^4 + z^6 - 3*x^2*y^2*z^2;

% constraint polynomials 
gList = {x,y,z,x^2+y^2+z^2};          

% relaxation orders 
k = 3;         % SOS half-degree   (2k = 6)
d = 3;          % multiplier degree

% call bounded-SOS+SONC solver 
[val, diagnostics, fSOS, fSONC, hSOS, hSONC, lambdaOpt] =  boundedSOSplusSONC(f, gList, vecVar, k, d, 1);

% optimal value
val