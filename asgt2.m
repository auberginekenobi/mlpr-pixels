% imgregred contains the nf variables in imgregdata, with the underscores
% in the variable names removed.
load('imgregred');
%{
2a
From figure 2a, it appears that the label increases linearly with the 
pixels above and to the left.
%}
% getting a subset of xtrnf, ytrnf

pkg load signal;

xtrnfDown = downsample(xtrnf,20);
ytrnfDown = downsample(ytrnf,20);

% figure;
% scatter3(xtrnfDown(:,end),xtrnfDown(:,end-34),ytrnfDown);
% title({'2a. Relationship of label pixel to those to the left and above it,','from 863 elements of the xtr\_nt set.'});
% xlabel('left of label');
% ylabel('above label');
% zlabel('label');

%{
2b
w = (Phi^T Phi)^-1 Phi^T y
%}

%{
2c
w = [0.4606, 0.5241, 0.0026]T
rmse of the test set = 0.0503
rmse of the training set = 0.0506

The linear regressor performs somewhat well, which is expected as there is high 
correlation between the unknown pixel and the pixels to the left and above. The
RMSEs of the training and test sets are small compared to the possible range of 
the data [0,1]; and are very close across the two sets.  The similarity of the
two RMSEs indicates that the line is probably not overfitted; the line fits the
training set about as well as the test set.
%}
% generates Phi
fmatrix = horzcat(xtrnf(:,end),xtrnf(:,end-34),ones(17261,1));
% w = (Phi^T Phi)^-1 Phi^T y
w = (transpose(fmatrix)*fmatrix)^(-1)*transpose(fmatrix)*ytrnf

% predict
testmatrix = transpose(horzcat(xtenf(:,end),xtenf(:,end-34),ones(7309,1)));
predictions = transpose(w)*testmatrix;

% evaluate predictions (test)
squerror = (transpose(predictions) - ytenf).^2;
testrmse = sqrt(mean(squerror))

% predict and evaluate training set as well
trpredictions = transpose(w)*transpose(fmatrix);
squerror = (transpose(trpredictions) - ytrnf).^2;
trainrmse = sqrt(mean(squerror))

% visualize
[dim1, dim2] = meshgrid(0:0.01:1,0:0.01:1);
ysurf = [[dim1(:), dim2(:)], ones(numel(dim1),1)]*w;
% figure;
% surf(dim1, dim2, reshape(ysurf, size(dim1)))
% hold on
% scatter3(xtrnfDown(:,end),xtrnfDown(:,end-34),ytrnfDown);
% title({'2c. Relationship of label pixel to those to the left and above it,','superimposed on the linear regression surface.'});
% xlabel('left of label');
% ylabel('above label');
% zlabel('label');
