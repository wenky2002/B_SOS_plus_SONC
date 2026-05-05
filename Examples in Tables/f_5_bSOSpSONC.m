%% This is f5 in Table 1
yalmip('clear');

% decision variables 
sdpvar x 
vecVar = [x];

% objective function       
f  = (x-1)^2*(x-2)^2;

% constraint polynomials 
gList = {x};          

% relaxation orders 
k = 2;         % SOS half-degree   (2k = 6)
d = 1;          % multiplier degree

% call bounded-SOS+SONC solver 
[val, diagnostics, fSOS, fSONC, hSOS, hSONC, lambdaOpt] =  boundedMinSOSpSONC(f, gList, vecVar, k, d, 1);