close all;
clear;

sig1 = 24;
sig2 = 24.5;

N = 256;
width = 48;
start = (N - width)/2;

f1 = make2DGaussian(N, sig1);
f2 = make2DGaussian(N, sig2);
%compute DOG
dog1 = f1 - f2;
dog2 = -dog1;
%create the double opponent cell
dogrgb = zeros(N,N,3);
dogrgb(:,:,1) = dog1;
dogrgb(:,:,2) = dog2;

%first image of red square white background
I1 = ones(N,N,3);
I1(start + 1: start + width, start + 1: start + width,1) = 1;
I1(start + 1: start + width, start + 1: start + width,2) = 0;
I1(start + 1: start + width, start + 1: start + width,3) = 0;
figure
image(I1);

dog = (filter2(dog1, I1(:,:,1)) + filter2(dog2, I1(:,:,2)))/3;

dogrgbfinal = zeros(size(I1));
%compute the filter output
dogrgbfinal(:,:,1) = filter2(I1(:,:,1),dogrgb(:,:,1));
dogrgbfinal(:,:,2) = filter2(I1(:,:,2),dogrgb(:,:,2));
dogrgbfinal(:,:,3) = filter2(I1(:,:,3),dogrgb(:,:,3));
dogrgbfinal = dogrgbfinal./max(dogrgbfinal(:));

figure
imagesc(dog);
colormap(gray(256))
figure
image(dogrgbfinal);

%image of red square with green background
I2 = ones(N,N,3);
I2(:,:,1) = 0;
I2(:,:,2) = 1;
I2(:,:,3) = 0;
I2(start + 1: start + width, start + 1: start + width,1) = 1;
I2(start + 1: start + width, start + 1: start + width,2) = 0;
I2(start + 1: start + width, start + 1: start + width,3) = 0;
figure
image(I2);
colormap(gray(256))

dog = filter2(dog1, I2(:,:,1)) + filter2(dog2, I2(:,:,2));
dogrgbfinal(:,:,1) = filter2(dogrgb(:,:,1) , I2(:,:,1));
dogrgbfinal(:,:,2) = filter2(dogrgb(:,:,2) , I2(:,:,2));
dogrgbfinal(:,:,3) = filter2(dogrgb(:,:,3) , I2(:,:,3));
dogrgbfinal = dogrgbfinal./max(dogrgbfinal(:));

figure
imagesc(dog);
colormap(gray(256))
figure
image(dogrgbfinal);

%image of green sqaure with white background
I2 = ones(N,N,3);
I2(start + 1: start + width, start + 1: start + width,1) = 0;
I2(start + 1: start + width, start + 1: start + width,2) = 1;
I2(start + 1: start + width, start + 1: start + width,3) = 0;
figure
image(I2);
colormap(gray(256))

dog = filter2(dog1, I2(:,:,1)) + filter2(dog2, I2(:,:,2));
dogrgbfinal(:,:,1) = filter2(dogrgb(:,:,1) , I2(:,:,1));
dogrgbfinal(:,:,2) = filter2(dogrgb(:,:,2) , I2(:,:,2));
dogrgbfinal(:,:,3) = filter2(dogrgb(:,:,3) , I2(:,:,3));
dogrgbfinal = dogrgbfinal./max(dogrgbfinal(:));

figure
imagesc(dog);
colormap(gray(256))
figure
image(dogrgbfinal);

%image of green square with red background
I2 = ones(N,N,3);
I2(:,:,1) = 1;
I2(:,:,2) = 0;
I2(:,:,3) = 0;
I2(start + 1: start + width, start + 1: start + width,1) = 0;
I2(start + 1: start + width, start + 1: start + width,2) = 1;
I2(start + 1: start + width, start + 1: start + width,3) = 0;
figure
image(I2);
colormap(gray(256))

dog = filter2(dog1, I2(:,:,1)) + filter2(dog2, I2(:,:,2));
dogrgbfinal(:,:,1) = filter2(dogrgb(:,:,1) , I2(:,:,1));
dogrgbfinal(:,:,2) = filter2(dogrgb(:,:,2) , I2(:,:,2));
dogrgbfinal(:,:,3) = filter2(dogrgb(:,:,3) , I2(:,:,3));
dogrgbfinal = dogrgbfinal./max(dogrgbfinal(:));

figure
imagesc(dog);
colormap(gray(256))
figure
image(dogrgbfinal);

%image of white square with black background
I2 = zeros(N,N,3);
I2(start + 1: start + width, start + 1: start + width,1) = 1;
I2(start + 1: start + width, start + 1: start + width,2) = 1;
I2(start + 1: start + width, start + 1: start + width,3) = 1;
figure
image(I2);
colormap(gray(256))

dog = filter2(dog1, I2(:,:,1)) + filter2(dog2, I2(:,:,2));
dogrgbfinal(:,:,1) = filter2(dogrgb(:,:,1) , I2(:,:,1));
dogrgbfinal(:,:,2) = filter2(dogrgb(:,:,2) , I2(:,:,2));
dogrgbfinal(:,:,3) = filter2(dogrgb(:,:,3) , I2(:,:,3));
dogrgbfinal = dogrgbfinal./max(dogrgbfinal(:));

figure
imagesc(dog);
colormap(gray(256))
figure
image(dogrgbfinal);