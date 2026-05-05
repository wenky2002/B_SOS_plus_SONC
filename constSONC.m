function [const,decompVec] = constSONC(coeff, exponents, indInnerTerms)
% CONSTSONC computes the relative entropy programming constraint set, which
% can be used to decide, if a given polynomial lies in the SONC cone.
%
%   Let f be the polynomial, corresponding to the coefficient vector
%   'coeff' and the exponent matrix 'exp'. We compute the relative entropy
%   programming constraint set of the SONC cone, which certifies if the
%   signomial representative of f with respect to 'indInnerTerm' is SAGE.
%   The vector 'indInnerTerms' corresponds to columns of the exponent
%   matrix 'exp'. If 'indInnerTerms' corresponds to all columns, which are
%   not even lattice points, this decides membership in the SONC cone.
%
%   Input:v
%   - coeff: coefficient vector of the polynomial of interest.
%   - exp: exponent matrix of the polynomial of interest.
%   - indInnerTerms: vector of indices of inner Terms used for the
%   signomial representative.
%
%   Output: 
%   - const: The constraint set for the SONC cone.
%   - decompVec: vector [c(1);...;c(m); nu(1);...;nu(m)] of relative
%   entropy constraint variables used to decide membership in the SAGE
%   cone. 'm' is the number of exp/ monomials of 'f'.

[numVar,numExp] = size(exponents);
decompVec = sdpvar(2*numExp^2,1);
const = [];

%% Constraint: c(i)'s sum up to 'coeff'.
constSumCoeff = [kron(ones(1,numExp),speye(numExp)),...
    sparse(numExp,numExp^2)];
const = [const, constSumCoeff*decompVec==coeff];

%% Constraint: sum over all i, exp(:,i)*nu(k)_i is zero vector for all k.
constSumAlphaNu = [sparse(numExp*numVar,numExp^2),...
    kron(speye(numExp,numExp),exponents)];
const=[const,constSumAlphaNu*decompVec==0];

%% Constraint: Components of every nu(k) sum up to zero vector.
constSumComponentsNu = [sparse(numExp, numExp^2),...
    kron(speye(numExp,numExp), ones(1,numExp))];
const = [const, constSumComponentsNu*decompVec==0];

%% Constraint: nu(k)_j>=0 for all j~=k.
constNuNonneg = zeros(numExp*(numExp-1),1);
for j=1:numExp
    constNuNonneg((j-1)*(numExp-1)+(1:(numExp-1))) = ...
        numExp^2+(j-1)*numExp+setdiff(1:numExp,j);
end
const = [const, decompVec(constNuNonneg)>=0];

%% Constraint: c(k)_j>=0 for all j~=k.
constCNonneg=zeros(numExp*(numExp-1),1);
for j=1:numExp
    constCNonneg((j-1)*(numExp-1)+(1:(numExp-1))) = ...
        (j-1)*numExp+setdiff(1:numExp,j);
end
const = [const, decompVec(constCNonneg)>=0];

%% Constraint: c(k)_j=nu(k)_j=0 for all indices j in 'indInnerTerms'.
% Since we already have the constraints nu(k)_jk, c(k)_j>=0 for all j~=k, 
% it suffices to add the constraints c(k)_j,nu(k)_j<=0 for all indices j of
% inner terms with j~=k.
if length(indInnerTerms)>=1
    constCNonpos = zeros(2*(numExp-1)*length(indInnerTerms),1);
    for k=1:length(indInnerTerms)
        positionCj = setdiff(1:numExp,indInnerTerms(k));
        for j=1:length(positionCj)
            constCNonpos((k-1)*(numExp-1)+j)=...
                (positionCj(j)-1)*numExp+indInnerTerms(k);
            constCNonpos((length(indInnerTerms)+k-1)*(numExp-1)+j)=...
                numExp^2+(positionCj(j)-1)*numExp+indInnerTerms(k);
        end
    end
    const=[const, decompVec(constCNonpos)<=0];
end

%% Constraint: Relative entropy function inequalities for all indices.
constRelEntAllInd=sdpvar(numExp,1);
for j=1:numExp
    constRelEntAllInd(j)=...
        (kullbackleibler(decompVec(numExp^2+(j-1)*numExp+...
        setdiff(1:numExp,j)), (exp(1)*decompVec((j-1)*numExp+...
        setdiff(1:numExp,j))))) - decompVec((j-1)*numExp+j);
end
const=[const, constRelEntAllInd<=0];

%% Constraint: Relative entropy inequalities for indices of inner terms.
if length(indInnerTerms)>=1
    constRelEntInnerTerms = sdpvar(length(indInnerTerms),1);
    for j=1:length(indInnerTerms)
        constRelEntInnerTerms(j) = ...
            (kullbackleibler(decompVec(numExp^2 +...
            (indInnerTerms(j)-1)*numExp +...
            setdiff(1:numExp,indInnerTerms(j))),...
            (exp(1)*decompVec((indInnerTerms(j)-1)*numExp +...
            setdiff(1:numExp,indInnerTerms(j))))))...
            + decompVec((indInnerTerms(j)-1)*numExp+indInnerTerms(j));
    end
    const = [const, constRelEntInnerTerms<=0];
end
end

