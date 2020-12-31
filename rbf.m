function retval = rbf (r, rbfFunc, beta)
  switch rbfFunc
    case 'gaussian'
      retval = exp(-(beta .* r) .^ 2);
    case 'multiquadric'
      retval = sqrt(1 .+ (beta .* r) .^ 2);
    case 'inverse-quadric'
      retval = (1 + (beta .* r) .^ 2) .^ -1;
    case 'polynomial'
      retval = (r .^ 2) .+  (beta ^ 2);
    case 'thin-plate-spline'
      retval = zeros(size(r));
      I = (r > 0);
      retval(I) = (r(I) .^ 2) .*  log(r(I));
    otherwise
      retval = rbf(r, 'gaussian', beta);
  end
endfunction
