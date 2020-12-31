clear all;
clc;
close all;

ymin = -2;
ymax = 2;
ystep = .2;

xmin = -2;
xmax = 2;
xstep = .2;

K = 100;
beta = 0.75;
rbfFunc = 'thin-plate-spline';

func = @(x, y) sin(pi * x) .* sin((pi/2)*y) .* exp(-(x.^2 + y.^2) ./ 6);
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

# Calculate rbf coefficients
Coeffs = getRbfCoefficients(Xrands, Zrand, rbfFunc, beta);

# Evaluate RBF for not known points
Zinter = evaluateRbf(Coeffs, Xrands, XSpaces, rbfFunc, beta);
Zinter = reshape(Zinter, [size(X, 1), size(X, 2)]);

# Plot the results
figure(1)
scatter(Xrand, Yrand);
title("Random points");
xlabel("X");
ylabel("Y");

plotResults(X, Y, Z, Zinter);