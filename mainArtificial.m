clear all;
clc;
close all;

ymin = -2;
ymax = 2;
ystep = .2;

xmin = -2;
xmax = 2;
xstep = .2;

K = 150;

func = @(x, y) cos(abs(x).+abs(y)).*(abs(x).+abs(y))
getRandomXs = @() (xmax - xmin) .* rand(K, 1) + xmin;
getRandomYs = @() (ymax - ymin) .* rand(K, 1) + ymin;

# Generate known surface
[X,Y] = meshgrid(xmin:xstep:xmax, ymin:ystep:ymax);
XSpaces = [reshape(X,[],1), reshape(Y,[],1)];
Z = func(X, Y);

# Pick some random point from surface
Xrand = getRandomXs();
Yrand = getRandomYs();
Xrands = [Xrand Yrand];
Zrand = func(Xrand, Yrand);

figure(1)
scatter(Xrand, Yrand);
title("Random points");
xlabel("X");
ylabel("Y");


smallestError = inf;
bestBeta = 0.5;
bestRbfFunc = 'gaussian';
bestZinter = zeros(size(X, 1), size(X, 2));

rbfFuncs = {"gaussian", "multiquadric", "inverse-quadric", "polynomial", "thin-plate-spline"};
for beta = [0.5, 0.75, 1, 1.25, 1.5, 2]
  for rbfFuncIndex = 1:length(rbfFuncs)
    rbfFunc = rbfFuncs{rbfFuncIndex};

    # Calculate rbf coefficients
    Coeffs = getRbfCoefficients(Xrands, Zrand, rbfFunc, beta);

    # Evaluate RBF for not known points
    Zinter = evaluateRbf(Coeffs, Xrands, XSpaces, rbfFunc, beta);
    Zinter = reshape(Zinter, [size(X, 1), size(X, 2)]);

    # Plot the results
    Zerror = abs(Z-Zinter);
    maxError = max(Zerror(:));
    meanError = mean(Zerror(:));
    errors = maxError + meanError;
    if errors < smallestError
      smallestError = errors;
      bestBeta = beta;
      bestRbfFunc = rbfFunc;
      bestZinter = Zinter;
    end
  end
end

bestRbfFunc
bestBeta
plotResults(X, Y, Z, bestZinter);