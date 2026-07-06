%% This is f11 in Table 1 by using Gloptipoly3
mpol x y z
f = x^2*y^2 + x^2*z^2 + y^2*z^2 + 1 - 4*x*y*z;
g1 = x;
g2 = y;
g3 = z;
K = [0 <= g1, 0 <= g2, 0 <= g3, g1 <= 1, g2 <= 1, g3 <= 1];
P = msdp(min(f),K)
[status,obj] = msol(P)
