function Coeffs = getRbfCoefficients (samplePoints, sampleValues, rbfFunc, beta)
  ndims = size(samplePoints, 2);
  # +1 for constant factor
  ncols = ndims + 1;
  K = length(samplePoints);
  
  r = zeros(K);

  for i = 1:K
    for j = (i+1):K
      r(i, j) = norm(samplePoints(i, :) - samplePoints(j, :));
      r(j, i) = r(i, j);
    end
  end
  
  tmp = min(r(:))
  
  Rbfs = rbf(r, rbfFunc, beta);
  
  Poly = [ones(K, 1), samplePoints];

  Matrix = [Rbfs, Poly; transpose(Poly), zeros(ncols)];
  y = [sampleValues; zeros(ncols, 1)];
  
  Coeffs = Matrix \ y;
endfunction
