% imgregred contains the nf variables in imgregdata, with the underscores
% in the variable names removed.
load('imgregred');
load('welltrainedMLP');

%use the underscores
xtr_nf = xtrnf;

%{
5a
Compute the RMSE on both the training and test set using Netlab function
mlpfwd(). Compare its RMSEs with those from linear regression, and comment
on the differences.

%}
% RMSE on training set
ypred_tr = mlpfwd(welltrainednet, xtr_nf);
rmse_NNsuball_tr = sqrt(mean(((ytr_nf - ypred_tr).^2)))
% RMSE on test set
ypred = mlpfwd(welltrainednet, xte_nf);
rmse_NNsuball_te = sqrt(mean(((yte_nf - ypred).^2)))


%% Neural Network with all pixels
%{
5b
Report the training and testing
RMSEs for each run. Comment on any differences, and explain why these may
occur.

%}

function network
% Set up the network
nhid = 10; % number of hidden units
net = mlp(size(xtr_nf,2), nhid, 1, ’linear’);
% Set up vector of options for the optimiser.
options = zeros(1,18);
options(1) = 1; % This provides display of error values.
options(9) = 1; % Check the gradient calculations.
options(14) = 200; % Number of training cycles.
% Train using scaled conjugate gradients.
[net, options] = netopt(net, options, xtr_nf(1:5000,:), ytr_nf(1:5000,:), ’scg’);
toc
% RMSE on training set
ypred_tr = mlpfwd(net, xtr_nf);
rmse_NNsuball_tr = sqrt(mean(((ytr_nf - ypred_tr).^2)))
% RMSE on test set
ypred = mlpfwd(net, xte_nf);
rmse_NNsuball_te = sqrt(mean(((yte_nf - ypred).^2)))
end

for i=2015:2019
  rng(i,'twister')
  network();
end