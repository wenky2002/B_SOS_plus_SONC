%% This is f4 in Table 1
yalmip('clear');

% decision variables 
sdpvar x y
vecVar = [x y];

% objective function       
f  = x^6 + y^6 + 1 - (x^4*y^2 + x^4 + x^2*y^4 + x^2 + y^4 + y^2) + 3*x^2*y^2;

% constraint polynomials 
gList = {x,y};          

% relaxation orders 
k = 3;         % SOS half-degree   (2k = 6)
d = 5;          % multiplier degree

% call bounded-SOS+SONC solver 
[val, diagnostics, fSOS, fSONC, hSOS, hSONC, lambdaOpt] =  boundedMinSOSpSONC(f, gList, vecVar, k, d, 1);