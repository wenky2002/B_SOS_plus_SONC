%% This is f1 in Table 1 by using Gloptipoly3
mpol x y
f = x^4*y^2 + x^2 + y^4 - 3*x^2*y^2;
g1 = x;
g2 = y;
g3 = x^2 + y^2;
K = [0 <= g1, 0 <= g2, 0 <= g3,g1 <= 1, g2 <= 1, g3 <= 1];
P = msdp(min(f),K)
[status,obj] = msol(P)
