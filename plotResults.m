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
  meanError = mean(Zerror(:));
  
  surf(X,Y,Zerror);
  maxErrorInfo = strcat("max error: ", num2str(maxError));
  meanErrorInfo = strcat("mean error: ", num2str(meanError));
  errorTitle = strcat("Error - ", maxErrorInfo, " - ", meanErrorInfo);
  title(errorTitle);
  xlabel("X");
  ylabel("Y");
  zlabel("error");
endfunction
