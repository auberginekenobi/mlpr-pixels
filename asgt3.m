% imgregred contains the nf variables in imgregdata, with the underscores
% in the variable names removed.
load('imgregred');
addpath('netlab3_3');
pkg load statistics; % octave

% Code for creating RBF and making predictions
% nbf is the number of basis functions - [5, 10, 15, 20, 25, 30]
% dim is the dimensionality of input space - in this case 1032
%net = rbf(dim, nbf, 1, ’gaussian’);
%options = foptions;
%options(1) = 1; % Display EM training
%options(14) = 5; % number of iterations of EM
%net = rbftrain(net, options, YourTrainingX, YourTrainingY ); % train the net
%ypred = rbffwd(net, YourTestX); % use the net to predict the output
% for YourTestX;

%mse = crossval('mse',X,y,'Predfun',predfun)
%yfit = predfun(XTRAIN,ytrain,XTEST)
%regf=@(XTRAIN,ytrain,XTEST)(XTEST*regress(ytrain,XTRAIN));
makerbf=@(nbf) (rbf(1032,nbf,1,'gaussian'));
net=makerbf(5);
options = foptions;
options(1) = 1; % Display EM training
options(14) = 5; % number of iterations of EM
net = rbftrain(net, options, xtrnf, ytrnf ); % train the net
ypred = rbffwd(net, xtrnf);
ypred
%net=makerbf(5);
%trainrbf=@(XTRAIN,ytrain,XTEST) (rbffwd(rbftrain(net,options,XTRAIN,ytrain),XTEST)); %should these be xtrnf, ytrnf?
% mse = crossval('mse',xtrnf,ytrnf,'Predfun',trainrbf) % matlab
%octavemse=@(XTRAIN,ytrain,XTEST,ytest) (sqrt(mean((trainrbf(XTRAIN,ytrain,XTEST)-ytenf).^2)));
%mse = crossval(octavemse,xtrnf,ytrnf) % octave

%function net = makerbf(nbf)
%net = rbf(1032,nbf,1,'gaussian');
%end

