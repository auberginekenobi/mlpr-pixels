%load imgregdata.mat
%data = matfile('imgregdata.mat');
%data.xtr(1,1)
load('imgregdata');
xtr = xtr / 63;
ytr = ytr / 63;
xte = xte / 63;
yte = yte / 63;
xtr(1,1)