function [Z] = evaluateRbfLocal (Coeffs, Xknowns, X, rbfFunc, beta, r0)
  K = length(Xknowns); 
  N = size(X, 1);
 
  r = zeros(N, K);
  
  for i = 1:N
      for j = 1:K
          r(i, j) = norm( X(i, :) - Xknowns(j, :) );
      end
  end
  
  P = [ones(N, 1), X];
  Rbfs = rbfLocal(r, rbfFunc, beta, r0);
  
  Z = [Rbfs, P]*Coeffs;
endfunction
