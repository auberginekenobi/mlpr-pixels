% imgregred contains the nf variables in imgregdata, with the underscores
% in the variable names removed.
load('imgregred');
%{
2a
From figure 2a, it appears that the label increases linearly with the 
pixels above and to the left.
%}
% getting a subset of xtrnf, ytrnf

%pkg load signal; % octave


%{
2c
w = now a very long vector of rather minute weights
rmse of the test set = 0.0456
rmse of the training set = 0.0371
(--- reminder of the rmses for just two features
rmse of the test set = 0.0503
rmse of the training set = 0.0506
---)

The linear regressor over all pixels (LROAP) in the patch performs slightly better on 
the test set than that over the left and above pixels, indicating that the 
other pixels provide some slight information gain not contained in the nearest
two.  However, the LROAP also has a smaller rmse for the training set than for
the test set, indicating that the addition of more features has overfit the line
to the training set.
** COMPARE TO THE RADIAL BASIS REGRESSOR **
%}

% generates Phi
fmatrix = horzcat(xtrnf,ones(17261,1));
% w = (Phi^T Phi)^-1 Phi^T y
w = (transpose(fmatrix)*fmatrix)^(-1)*transpose(fmatrix)*ytrnf;

% predict
testmatrix = transpose(horzcat(xtenf,ones(7309,1)));
predictions = transpose(w)*testmatrix;

% evaluate predictions (test)
squerror = (transpose(predictions) - ytenf).^2;
testrmse = sqrt(mean(squerror))

% predict and evaluate training set as well
trpredictions = transpose(w)*transpose(fmatrix);
squerror = (transpose(trpredictions) - ytrnf).^2;
trainrmse = sqrt(mean(squerror))

