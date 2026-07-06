%% This is f6 in Table 1
yalmip('clear');

% decision variables 
sdpvar x y z
vecVar = [x y z];

% objective function       
Q = x^2*y^2 + x^2*z^2 + y^2*z^2 + 1 - 4*x*y*z;
f = Q + (1-x^2)^2 + (1-y^2)^2 + (1-z^2)^2;

% constraint polynomials 
gList = {x y z};          

% relaxation orders 
k = 3;         % SOS half-degree   (2k = 6)
d = 1;          % multiplier degree

% call bounded-SOS+SONC solver 
[val, diagnostics, fSOS, fSONC, hSOS, hSONC, lambdaOpt] =  boundedSOSplusSONC(f, gList, vecVar, k, d, 1);
