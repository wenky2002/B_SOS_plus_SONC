function [monNewF, exponentsNewF]= newtonPolytope(f, vecVar)
% NEWTONPOLYTOPE computes the lattice points in the Newton polytope of a 
% given polynomial 'f'.
%
%   Given a polynomial 'f', compute the exponent matrix 'expNewF', whose
%   columns are all lattice point in the Newton polytope of 'f'. Further,
%   compute the vector 'monNewF' of monomials with coefficient 1 such that 
%   the exponent of the i-th component of 'monNewF' is the i-th column of
%   'expNewF'. The variables used must be YALMIP sdpvar decision variables.
%
%   Input:
%   - f: the given polynomial.
%   - vecVar: vector of variables in which 'f' is defined. Can be row or
%   column vector.
%
%   Output:
%   - monNewF: column vector containing all monomials in the Newton polytope
%   of 'f'.
%   - exponentsNewF: exponent matrix, columns are lattice points in the 
%   Newton polytope of 'f'.

% Get all monomials of 'f' 
[~, monomialsF] = coefficients(f, vecVar);
% And a basis of the vector space of real polynomials, degree at most deg(f).
monAll = monolist(vecVar, degree(f));
numMonAll = length(monAll); 

% Get two exponent matrices. First, containing all exponents in the support of f 
expF = exponentsFromMonomials(monomialsF, vecVar);
% And second all exponents of all monomials, degree at most deg(f).
expAll = exponentsFromMonomials(monAll, vecVar);

% For all exponents in the monomial basis, check if they are in the Newton
% polytope of 'f', i.e. if they are a convex combination of the elements of
% the support of f.
isContained = zeros(1, numMonAll);
for i = 1:numMonAll
    coeffConvexComb = sdpvar(length(monomialsF), 1);  % Define a column vector 'coeffConvexComb'
    exponentToBeTested = expAll(:, i); % Extract i-th exponent vector in expAll
    const = [expF*coeffConvexComb==exponentToBeTested,...
        sum(coeffConvexComb)==1, coeffConvexComb>=0];
    obj = 0;
    % Let YALMIP choose a solver on its own.
    solverOptions = sdpsettings('solver', 'mosek', 'verbose', 0);
%     % Use ECOS.
%     solverOptions = sdpsettings('solver', 'ecos', 'verbose', 0);
%     % Use MOSEK.
%     solverOptions = sdpsettings('solver', 'mosek', 'verbose', 0);
    diagnostics = optimize(const, obj, solverOptions);
    if diagnostics.problem==0
        % exponentTest is contained in the Newton polytope.
        isContained(i) = 1;
    end
end

monNewF=monAll(logical(isContained));
exponentsNewF=expAll(:, logical(isContained));
end

