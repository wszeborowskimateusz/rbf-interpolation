function retval = rbfLocal (r, r0)
  retval = zeros(size(r));
  r = r/r0;
  
  L = (r <= 1);

  #CP_C6
  retval(L) = (1 - r(L)).^8.*(32*r(L).^3 + 25*r(L).^2 + 8*r(L) + 1);
endfunction
