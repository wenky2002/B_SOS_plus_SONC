% This is the example (5.9) appearing in Section 5.6.3
% B-SOS+SONC
yalmip('clear');

% decision variables 
sdpvar x y
vecVar = [x y];

% objective function = 1 − X2Y2 + X4Y2 + X2Y4      
f  = 1 - x^2*y^2 + x^4*y^2 + x^2*y^4;

% constraint polynomials 
gList = {x,y};          

% relaxation orders 
k = 3;         % SOS half-degree   (2k = 6)
d = 1;          % multiplier degree

% call bounded-SOS+SONC solver 
[val, diagnostics, fSOS, fSONC, hSOS, hSONC, lambdaOpt] = boundedSOSplusSONC(f, gList, vecVar, k, d, 1);

% optimal val

val
