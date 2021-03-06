

load('imgregdata');
% xtr = downsample(xtr,100) / 63;
% ytr = downsample(ytr,100) / 63;
% xte = downsample(xte,100) / 63;
% yte = downsample(yte,100) / 63;
xtr = xtr / 63;
xte = xte / 63;
ytr = ytr / 63;
yte = yte / 63;
%xtr(1,1)
stdev_xtr=std(xtr,0,2);
% 1a
figure
hist(stdev_xtr,64)
title({'1a. Standard deviations of the pixels', 'in each patch in the xtr data set'});
xlabel('Standard deviation');
ylabel('Number of instances');
%{
1a
We use 64 bins so that each bin corresponds to a single greyscale pixel value.
This plottells us that many of the patches have a very low standard deviation,
and thus the pixels in the patch have very similar values.

1b
A simple prediction for 'flat' patches is to predict the target as the mean
of the training set.

1c
%}
% find a flat and a nonflat patch
foundpatch = false;
foundnonpatch = false;
flatpatch = 0;
nonflatpatch = 0;
n=1;
while (foundpatch == false || foundnonpatch==false) && n<=70000
  if (stdev_xtr(n)>(4/64) && ~foundnonpatch)
    'found nonpatch'
    foundnonpatch = true;
    nonflatpatch=xtr(n,:);
  end
  if (stdev_xtr(n)<(4/64)&& ~foundpatch)
    'found patch'
    foundpatch = true;
    flatpatch=xtr(n,:);
  end
  n = n+1;
end
% resize each
flatpatch = transpose(reshape(horzcat(flatpatch,ones(1,18)),35,30));
nonflatpatch = transpose(reshape(horzcat(nonflatpatch,ones(1,18)),35,30));
% display each in its own figure.
figure
colormap gray;
imagesc(flatpatch,[0,1]);
title('1c. A Flat Image Patch from Dataset xtr');

figure
colormap gray;
imagesc(nonflatpatch,[0,1]);
title('1c. A Non-Flat Image Patch from Dataset xtr');



