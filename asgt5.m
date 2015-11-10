% imgregred contains the nf variables in imgregdata, with the underscores
% in the variable names removed.
load('imgregred');
load('welltrainedMLP');

%use the underscores
xtr_nf = xtrnf;
xte_nf = xtenf;
ytr_nf = ytrnf;
yte_nf = ytenf;

%{
5a
Compute the RMSE on both the training and test set using Netlab function
mlpfwd(). Compare its RMSEs with those from linear regression, and comment
on the differences.
rmse_tr = .0333
rmse_te = .0473
For comparison, the RMSEs for the training and test sets using linear
regression were .0371 and .0456 respectively.  Both sets of RMSEs are very
similar between a NN and LR, though the NN performs slightly better on the
training set and slightly worse on the test set.  This may indicate that
the hidden layers implemented in the NN are not too useful in predicting 
the test set; perhaps the values of the pixels themselves are better 
features than functions of these values implemented in the hidden layer.
%}
% RMSE on training set
ypred_tr = mlpfwd(net, xtr_nf);
rmse_NNsuball_tr = sqrt(mean(((ytr_nf - ypred_tr).^2)))
% RMSE on test set
ypred = mlpfwd(net, xte_nf);
rmse_NNsuball_te = sqrt(mean(((yte_nf - ypred).^2)))


% Neural Network with all pixels
%{
5b
Report the training and testing
RMSEs for each run. Comment on any differences, and explain why these may
occur.
trainrmses = 0.0503 0.0478 0.0485 0.0488 0.0489
testrmses =  0.0519 0.0511 0.0515 0.0527 0.0526
The training RMSEs are all slightly less than the corresponding test RMSEs,
which is to be expected. This difference is quite small, however,
indicating that the NNs are pretty good at avoiding overfitting. A
given NN also has slightly different RMSE values than any other; this is
because the weights for each neural connection are initialized randomly and
then optimized.  Each NN therefore represents a different local minimum in
the function that transforms the weight space to prediction error.
%}


testrmses=[0 0 0 0 0];
trainrmses=[0 0 0 0 0];
for i=2015:2019
  rng(i,'twister')
  % Set up the network
  nhid = 10; % number of hidden units
  net = mlp(size(xtr_nf,2), nhid, 1, 'linear');
  % Set up vector of options for the optimiser.
  options = zeros(1,18);
  options(1) = 1; % This provides display of error values.
  options(9) = 1; % Check the gradient calculations.
  options(14) = 200; % Number of training cycles.
  % Train using scaled conjugate gradients.
  [net, options] = netopt(net, options, xtr_nf(1:5000,:), ytr_nf(1:5000,:), 'scg');
  % toc
  % RMSE on training set
  ypred_tr = mlpfwd(net, xtr_nf);
  rmse_NNsuball_tr = sqrt(mean(((ytr_nf - ypred_tr).^2)))
  % RMSE on test set
  ypred = mlpfwd(net, xte_nf);
  rmse_NNsuball_te = sqrt(mean(((yte_nf - ypred).^2)))
  testrmses(i-2014)=rmse_NNsuball_te;
  trainrmses(i-2014)=rmse_NNsuball_tr;
end
trainrmses
testrmses


