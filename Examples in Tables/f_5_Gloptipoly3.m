%% This is f5 in Table 1 by using Gloptipoly3
mpol x 
f = (x-1)^2*(x-2)^2;
g1 = x;
K = [0 <= g1, g1 <= 1];
P = msdp(min(f),K)
[status,obj] = msol(P)
