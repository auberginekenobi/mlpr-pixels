% imgregred contains the nf variables in imgregdata, with the underscores
% in the variable names removed.
load('imgregred');
%{
2a
From figure 2a, it appears that the label increases linearly with the 
pixels above and to the left.
%}
% getting a subset of xtrnf, ytrnf
xtrnfDown = downsample(xtrnf,20);
ytrnfDown = downsample(ytrnf,20);

figure;
scatter3(xtrnfDown(:,end),xtrnfDown(:,end-34),ytrnfDown);
title({'2a. Relationship of label pixel to those to the left and above it,','from 863 elements of the xtr\_nt set.'});
xlabel('left of label');
ylabel('above label');
zlabel('label');

%{
2b
w = (Phi^T Phi)^-1 Phi^T y
%}

%{
2c
w = [0.4606, 0.5241, 0.0026]T
rmse = 0.0503
The linear regressor performs somewhat well, as there is high correlation
between the unknown pixel and the pixels to the left and above. Most of the
label values are similar to the mean of the left and above pixels, leading
the regressor to weight both features pretty evenly and to have a low bias
term.
%}
% generates Phi
fmatrix = horzcat(xtrnf(:,end),xtrnf(:,end-34),ones(17261,1));
% w = (Phi^T Phi)^-1 Phi^T y
w = (transpose(fmatrix)*fmatrix)^(-1)*transpose(fmatrix)*ytrnf

% predict
testmatrix = transpose(horzcat(xtenf(:,end),xtenf(:,end-34),ones(7309,1)));
predictions = transpose(w)*testmatrix;

% evaluate predictions
squerror = (transpose(predictions) - ytenf).^2;
rmse = sqrt(mean(squerror))

% visualize
[dim1, dim2] = meshgrid(0:0.01:1,0:0.01:1);
ysurf = [[dim1(:), dim2(:)], ones(numel(dim1),1)]*w;
figure;
surf(dim1, dim2, reshape(ysurf, size(dim1)))
hold on
scatter3(xtrnfDown(:,end),xtrnfDown(:,end-34),ytrnfDown);
title({'2c. Relationship of label pixel to those to the left and above it,','superimposed on the linear regression surface.'});
xlabel('left of label');
ylabel('above label');
zlabel('label');
