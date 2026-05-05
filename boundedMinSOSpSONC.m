function [val, diagnostics, fSOS, fSONC, hSOS,hSONC,lambdaOpt] = ...
    boundedMinSOSpSONC(f, gList, x, k, d, verb)
% boundedMinSOSpSONC  –  one (k,d) of the bounded SOS+SONC hierarchy
%
%   Input:
%     f        :  objective polynomial
%     gList    :  constraint polynomials list {g_1,…,g_m}
%     x        :  variables
%     k, d     :  relaxation orders 
%     verb     :  0/1  –  solver verbosity  (default 1)
%
%   Output:
%     val      :  lower bound p_d^k 
%     diagnostics :  YALMIP diagnostic code
%     fSOS     :  SOS part 
%     fSONC    :  SONC part 
%     hSOS     :  SOS decomposition 
%     hSONC    :  SONC decomposition
%     lambdaOpt:  optimal multiplier vector
%

m = numel(gList);
%% Generate Lagrange multipliers
A = [];
for s = 0:d
    A = [A; partitions(2*m, s)];
end
lam = sdpvar(size(A,1),1);                
                             
%% Generate the Lagrange function L_d  
sdpvar t
Ld = f;
for r = 1:size(A,1)
    monTerm = 1;   
    a = A(r, 1:m);
    b = A(r, m+1:end);
    for j = 1:m
        monTerm = monTerm*gList{j} ^ a(j) *(1 - gList{j}) ^ b(j);
    end
    Ld = Ld - lam(r) * monTerm;          
end
P = Ld - t;         
clear monTerm
                             
%% SOS block of degree <= 2k
monSOS = monolist(x,k);
nSOS    = length(monSOS);
Q   = sdpvar(nSOS);
fSOS = monSOS'*Q*monSOS;

%% Generate SONC constraints.
% Compute Newton polytope for SONC
[monSONC, expSONC] = newtonPolytope(P, x);
numMonSONC = length(monSONC); 
% Identify non - square monomials
helpExponentsOdd = mod(expSONC,2);
if size(expSONC,1)>=2
    helpExponentsOdd = any(helpExponentsOdd);
else
    helpExponentsOdd = logical(helpExponentsOdd);
end
allIndices = 1:numMonSONC;
indInnerTerms = allIndices(helpExponentsOdd);

% SONC decomposition over Newton polytope
coeffSONC = sdpvar(numMonSONC, 1);
fSONC = coeffSONC' * monSONC;
[consSONC, decVec] = constSONC(coeffSONC, expSONC, indInnerTerms);

%% Solve SDP-REP problem
const = [(coefficients(P - fSOS - fSONC, x) == 0),
      consSONC,
      Q>=0,
      lam>=0];

options = sdpsettings('solver','mosek','verbose',verb);
diagnostics = optimize(const, -t, options);

%% Outputs
val = value(t);
lambdaOpt = value(lam);
if diagnostics.problem == 0
    disp('YALMIP: Successfully solved.')
     if nargout >= 3
       % Get SOS and SONC summands of 'f' numerically.
        [cSOS, vSOS] = coefficients(fSOS, x);
        fSOS = value(cSOS)' * vSOS;
        
        [cSONC, vSONC] = coefficients(fSONC, x);
        fSONC = value(cSONC)' * vSONC;

    end
        if nargout >= 5
        hSOS  = sosd(fSOS);     
        dec  = value(decVec);
        hSONC = sdpvar(numMonSONC,1);
        for i = 1:numMonSONC
            hSONC(i) = dec((numMonSONC * (i - 1))...
                + 1:(numMonSONC * i))' * monSONC;
        end
        end
elseif diagnostics.problem == 1
    disp('YALMIP: Infeasible problem.')
else
    disp('YALMIP: Problem occurred:')
    disp(['Problem: ',num2str(diagnostics.problem)]);
end
problem=diagnostics.problem;

if ~problem == 0
    fSOS = -1;
    fSONC = -1;
    hSOS = [];
    hSONC = [];
    lambdaOpt = [];
end
end


