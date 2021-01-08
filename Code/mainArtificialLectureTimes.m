clear all;
clc;
close all;

ymin = -2;
ymax = 2;
ystep = .2;

xmin = -2;
xmax = 2;
xstep = .2;

beta = 0.75;
rbfFunc = 'gaussian';

func = @(x, y) sin(pi * x) .* sin((pi/2)*y) .* exp(-(x.^2 + y.^2) ./ 6);


# Generate known surface
[X,Y] = meshgrid(xmin:xstep:xmax, ymin:ystep:ymax);
XSpaces = [reshape(X,[],1), reshape(Y,[],1)];
Z = func(X, Y);

Ks = [100, 200, 300, 400, 500, 600, 700, 800, 900, 1000];
timesSolve = [];
timesEval = [];
maxErrors = [];
meanErrors = [];
for K=Ks
  getRandomXs = @() (xmax - xmin) .* rand(K, 1) + xmin;
  getRandomYs = @() (ymax - ymin) .* rand(K, 1) + ymin;

  # Pick some random point from surface
  Xrand = getRandomXs();
  Yrand = getRandomYs();
  Xrands = [Xrand Yrand];
  Zrand = func(Xrand, Yrand);

  # Calculate rbf coefficients
  tic;
  Coeffs = getRbfCoefficients(Xrands, Zrand, rbfFunc, beta);
  
  timeSolve = toc;
  timesSolve = [timesSolve; timeSolve];


  # Evaluate RBF for not known points
  tic;
  Zinter = evaluateRbf(Coeffs, Xrands, XSpaces, rbfFunc, beta);
  
  timeEval = toc;
  timesEval = [timesEval; timeEval];
  
  Zinter = reshape(Zinter, [size(X, 1), size(X, 2)]);
  
  Zerror = abs(Z-Zinter);
  maxError = max(Zerror(:));
  meanError = mean(Zerror(:));
  
  maxErrors = [maxErrors; maxError];
  meanErrors = [meanErrors; meanError];
end