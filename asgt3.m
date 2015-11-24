% imgregred contains the nf variables in imgregdata, with the underscores
% in the variable names removed.
load('imgregred');
addpath('netlab3_3');
% pkg load statistics; % octave

% Code for creating RBF and making predictions
% nbf is the number of basis functions - [5, 10, 15, 20, 25, 30]
% dim is the dimensionality of input space - in this case 1032

%{
3a
The RMSEs producedby different numbers of radial basis functions are all
almost the same, around 0.051, and the variation observed is well within 
the random error inherent in using cross-validation as a metric.  By
plotting these RMSEs against the number of radial basis functions used, 10
rbfs was selected as the best model from its slightly lower RMSE value.
%}

adjxtr=horzcat(xtrnf(:,end),xtrnf(:,end-34));
adjxte=horzcat(xtenf(:,end),xtenf(:,end-34));

makerbf=@(nbf) (rbf(2,nbf,1,'gaussian'));
%net=makerbf(5);
options = foptions;
options(1) = 1; % Display EM training
options(14) = 5; % number of iterations of EM
%net = rbftrain(net, options, adjxtr, ytrnf ); % train the net
%ypred = rbffwd(net, adjxte); % use the net to predict the output
% for YourTestX;
ypred(1)
rmses = [0 0 0 0 0];
for i=5:5:25
    net=makerbf(i);
    trainrbf=@(XTRAIN,ytrain,XTEST) (rbffwd(rbftrain(net,options,XTRAIN,ytrain),XTEST)); %should these be xtrnf, ytrnf?
    train_mse = crossval('mse',adjxtr,ytrnf,'Predfun',trainrbf) % matlab
    %test_mse = crossval('mse',adjxte,ytenf,'Predfun',trainrbf) % matlab
    rmses(1,i/5) = sqrt(train_mse);
end
rmses

figure;
scatter([5 10 15 20 25],rmses);
title({'Determining the optimal number of RBFs to use', 'in RBF regression on adjacent pixels'});
xlabel('Regressor RMSE');
ylabel('Number of radial basis functions');

%octavemse=@(XTRAIN,ytrain,XTEST,ytest) (sqrt(mean((trainrbf(XTRAIN,ytrain,XTEST)-ytenf).^2)));
%mse = crossval(octavemse,xtrnf,ytrnf) % octave

%{
3b
RMSE on the training set = 0.0505
RMSE on the test set = 0.0502
The RBF classifier performs slightly better on the test set than the linear
regressor, perhaps because the RBF is able to generate nonlinear curves.
But improvement is minimal, so it is arguable that the RBF approach does
not predict an adjacent pixel any better than a simple linear classifier.
%}

% predict the training and test sets
net = makerbf(10);
net = rbftrain(net,options,adjxtr,ytrnf);
trainpreds = rbffwd(net,adjxtr);
testpreds = rbffwd(net,adjxte);

% evaluate predictions
squerror = (trainpreds - ytrnf).^2;
trainrmse = sqrt(mean(squerror))

squerror = (testpreds - ytenf).^2;
testrmse = sqrt(mean(squerror))

