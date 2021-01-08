function [Z] = evaluateRbf (Coeffs, Xknowns, X, rbfFunc, beta)
  K = length(Xknowns); 
  N = size(X, 1);
 
  r = zeros(N, K);
  
  for i = 1:N
      for j = 1:K
          r(i, j) = norm( X(i, :) - Xknowns(j, :) );
      end
  end
  
  P = [ones(N, 1), X];
  Rbfs = rbf(r, rbfFunc, beta);
  
  Z = [Rbfs, P]*Coeffs;
endfunction
