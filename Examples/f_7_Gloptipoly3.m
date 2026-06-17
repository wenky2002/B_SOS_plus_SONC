%% This is f7 in Table 1 by using Gloptipoly3
mpol x y 
f = x^2*y^4 + x^4*y^2 + 1 - 3*x^2*y^2;
g1 = x;
g2 = y;
K = [0 <= g1, 0 <= g2, g1 <= 1, g2 <= 1];
P = msdp(min(f),K)
[status,obj] = msol(P)
