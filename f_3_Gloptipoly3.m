% This is the example (5.9) appearing in Section 5.6.3
% Gloptipoly3
mpol x y
f = 1 - x^2*y^2 + x^2*y^4 + x^4*y^2;
g1 = x;
g2 = y;
K = [0 <= g1, 0 <= g2, g1 <= 1, g2 <= 1];
P = msdp(min(f),K)
[status,obj] = msol(P)

