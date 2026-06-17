%% This is f1 in Table 1 by using bounded-SOS+SONC
yalmip('clear');

% decision variables 
sdpvar x y
vecVar = [x y];

% objective function        
f  = x^4*y^2 + x^2 + y^4 - 3*x^2*y^2;

% constraint polynomials 
gList = {x,y,x^2+y^2};          % g1 = x ,   g2 = y, g3 = x^2+y^2

% relaxation orders 
k = 3;         % SOS half-degree   (2k = 6)
d = 3;          % multiplier degree

% call bounded-SOS+SONC solver 
[val, diagnostics, fSOS, fSONC, hSOS, hSONC, lambdaOpt] =  boundedSOSplusSONC(f, gList, vecVar, k, d, 1);
