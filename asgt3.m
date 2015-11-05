% imgregred contains the nf variables in imgregdata, with the underscores
% in the variable names removed.
load('imgregred');

% Code for creating RBF and making predictions
% nbf is the number of basis functions
% dim is the dimensionality of input space
net = rbf(dim, nbf, 1, ’gaussian’);
options = foptions;
options(1) = 1; % Display EM training
options(14) = 5; % number of iterations of EM
net = rbftrain(net, options, YourTrainingX, YourTrainingY ); % train the net
ypred = rbffwd(net, YourTestX); % use the net to predict the output
% for YourTestX;

% subdivide sets into 10 subsets
% train 10 rbf classifiers, use remaining to validate 
% find averages
