% imgregred contains the nf variables in imgregdata, with the underscores
% in the variable names removed.
load('imgregred');
addpath('netlab3_3');
% pkg load statistics; % octave

% Code for creating RBF and making predictions
% nbf is the number of basis functions - [5, 10, 15, 20, 25, 30]
% dim is the dimensionality of input space - in this case 1032

adjxtr=horzcat(xtrnf(:,end),xtrnf(:,end-34));
adjxte=horzcat(xtenf(:,end),xtenf(:,end-34));

makerbf=@(nbf) (rbf(2,nbf,1,'gaussian'));
net=makerbf(5);
options = foptions;
options(1) = 1; % Display EM training
options(14) = 5; % number of iterations of EM
net = rbftrain(net, options, adjxtr, ytrnf ); % train the net
ypred = rbffwd(net, adjxte); % use the net to predict the output
% for YourTestX;
ypred(1)
mses = [0 0 0 0 0];
for i=5:5:25
net=makerbf(i);
trainrbf=@(XTRAIN,ytrain,XTEST) (rbffwd(rbftrain(net,options,XTRAIN,ytrain),XTEST)); %should these be xtrnf, ytrnf?
train_mse = crossval('mse',adjxtr,ytrnf,'Predfun',trainrbf) % matlab
test_mse = crossval('mse',adjxte,ytenf,'Predfun',trainrbf) % matlab
mses(1,i/5) = train_mse;
end
mses
horzcat(ypred(1:10),ytenf(1:10))

%octavemse=@(XTRAIN,ytrain,XTEST,ytest) (sqrt(mean((trainrbf(XTRAIN,ytrain,XTEST)-ytenf).^2)));
%mse = crossval(octavemse,xtrnf,ytrnf) % octave

% Why is my error so gigantic for every cycle (~-10k)?
% Why do I always get the same rmse no matter how many rbfs I use?

