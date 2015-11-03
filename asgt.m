%load imgregdata.mat
%data = matfile('imgregdata.mat');
%data.xtr(1,1)

pkg load signal;

load('imgregdata');
xtr = downsample(xtr,100) / 63;
ytr = downsample(ytr,100) / 63;
xte = downsample(xte,100) / 63;
yte = downsample(yte,100) / 63;
xtr(1,1)
stdev_xtr=std(xtr,0,2);
% 1a
%%figure
%%hist(stdev_xtr,64)
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
flatpatch = 0;
nonflatpatch = 0;
n=0;
while flatpatch == 0 && nonflatpatch==0 && n<=70000
  if (stdev_xtr(n)>(4/64))
    "found nonpatch"
    nonflatpatch=xtr(n);
  end
  if (stdev_xtr(n)<(4/64))
    "found patch"
    flatpatch=xtr(n);
  end
  n = n+1;
end
% display each in its own figure.
figure
colormap gray;
imagesc(flatpatch,[0,1]);
figure
colormap gray;
imagesc(nonflatpatch,[0,1]);

%{
2a
Here is a comment on the structure of the below plot.
%}

