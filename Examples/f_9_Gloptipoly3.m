%% This is f9 in Table 1 by using Gloptipoly3
mpol x y 
f = 0.5*(1 + 2*x*y +x^2*y)^2 + 2*(x^4*y^2 + x^2*y^4 + 1 - 3*x^2*y^2);
g1 = x;
g2 = y;
g3 = x^2 + y^2;
K = [0 <= g1, 0 <= g2, 0 <= g3, g1 <= 1, g2 <= 1, g3 <= 1];

global SDP_SOLVER
SDP_SOLVER = 'sdpt3';

P = msdp(min(f),K,10)
[status,obj] = msol(P)
