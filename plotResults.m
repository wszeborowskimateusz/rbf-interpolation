function [] = plotResults (X, Y, Z, Zinterpolated)

  
  # Original surface
  figure(2)
  surf(X,Y,Z)
  title("Original surface")
  xlabel("X")
  ylabel("Y")
  zlabel("Z")
  
  # Interpolated surface
  figure(3)
  surf(X,Y,Zinterpolated)
  title("Interpolated surface")
  xlabel("X")
  ylabel("Y")
  zlabel("Z")

  # Error
  figure(4)
  Zerror = abs(Z-Zinterpolated);
  maxError = max(Zerror(:));
  
  surf(X,Y,Zerror);
  title(strcat("Error - max error: ", num2str(maxError)));
  xlabel("X");
  ylabel("Y");
  zlabel("error");
endfunction
