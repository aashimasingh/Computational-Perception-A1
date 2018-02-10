close all;
clear;

question = 'a';
rad_to_deg = 180/pi;
pix_per_deg = 40;
pupil = 0.005;
small_to_large = 2;
lm_to_s = 1;
N = 256;
%image of 2 squares in a dark background
I = zeros(N, N, 3);
I(6*N/16+1 : 10*N/16,(N/8)+1 : (N/8)+64,1) = ones(N/4,N/4);
I(6*N/16+1 : 10*N/16,(N/8)+1 : (N/8)+64,2) = ones(N/4,N/4);
I(6*N/16+1 : 10*N/16,(N/8)+1 : (N/8)+64,3) = ones(N/4,N/4);
I(7*N/16 +1 : 9*N/16,11*N/16 +1 : 13*N/16,1) = ones(N/8,N/8);
I(7*N/16 +1 : 9*N/16,11*N/16 +1 : 13*N/16,2) = ones(N/8,N/8);
I(7*N/16 +1 : 9*N/16,11*N/16 +1 : 13*N/16,3) = ones(N/8,N/8);
figure
image(I);

switch question
    case 'a'
%difference between focal plane and far square
smalldiff = [1,0,-1,-2,-3];
for i = 1:5
    %compute the blur width
bwLM = pupil * abs(smalldiff(i)) * rad_to_deg * pix_per_deg;
bwLMlarge = pupil * abs(smalldiff(i) + small_to_large) * rad_to_deg * pix_per_deg ;
bwS = pupil * abs(smalldiff(i) - lm_to_s) * rad_to_deg * pix_per_deg;
bwSlarge = pupil * abs(smalldiff(i) + small_to_large - lm_to_s) * rad_to_deg * pix_per_deg; 
flm = fspecial('disk',bwLM+1E-30);
fs = fspecial('disk',bwS+1E-30);
%blur the image
flmlarge = fspecial('disk',bwLMlarge+1E-30);
fslarge = fspecial('disk',bwSlarge+1E-30);
Iblurred = zeros(N,N,3);
Iblurred(:,1:N/2,1) = filter2(flmlarge, I(:,1:N/2,1));
Iblurred(:,1:N/2,2) = filter2(flmlarge, I(:,1:N/2,2));
Iblurred(:,1:N/2,3) = filter2(fslarge, I(:,1:N/2,3));
Iblurred(:,N/2+1:N,1) = filter2(flm, I(:,N/2+1:N,1));
Iblurred(:,N/2+1:N,2) = filter2(flm, I(:,N/2+1:N,2));
Iblurred(:,N/2+1:N,3) = filter2(fs, I(:,N/2+1:N,3));
figure
imagesc(Iblurred);
if i == 1
    title('1D beyond far square')
elseif i == 2
    title('On the far square')
elseif i == 3
    title('At the midpoint between near and far square')
elseif i == 4
    title('On the near square')
else
    title('1D nearer than the near square')
end
    
end
    case 'b'
        sigma1 = 8;
        sigma2 = 9;
        %compute DOGs
        dog1 = make2DGaussian(N, sigma1) - make2DGaussian(N, sigma2);
        dog2 = -dog1;
        %difference between focal plane and far square
        smalldiff = [0,-2];
        for i = 1:2
            bwLM = pupil * abs(smalldiff(i)) * rad_to_deg * pix_per_deg;
            bwLMlarge = pupil * abs(smalldiff(i) + small_to_large) * rad_to_deg * pix_per_deg ;
            bwS = pupil * abs(smalldiff(i) - lm_to_s) * rad_to_deg * pix_per_deg;
            bwSlarge = pupil * abs(smalldiff(i) + small_to_large - lm_to_s) * rad_to_deg * pix_per_deg; 
            flm = fspecial('disk',bwLM+1E-30);
            fs = fspecial('disk',bwS+1E-30);
            flmlarge = fspecial('disk',bwLMlarge+1E-30);
            fslarge = fspecial('disk',bwSlarge+1E-30);
            Iblurred = zeros(N,N,3);
            Iblurred(:,1:N/2,1) = filter2(flmlarge, I(:,1:N/2,1));
            Iblurred(:,1:N/2,2) = filter2(flmlarge, I(:,1:N/2,2));
            Iblurred(:,1:N/2,3) = filter2(fslarge, I(:,1:N/2,3));
            Iblurred(:,N/2+1:N,1) = filter2(flm, I(:,N/2+1:N,1));
            Iblurred(:,N/2+1:N,2) = filter2(flm, I(:,N/2+1:N,2));
            Iblurred(:,N/2+1:N,3) = filter2(fs, I(:,N/2+1:N,3));
            figure
            imagesc(Iblurred);
            %create double opponent cell
            do = zeros(N,N,3);
            do(:,:,1) = dog1;
            do(:,:,2) = dog1;
            do(:,:,3) = dog2;
            %convolve the image channels with double opponent cell
            doubleoppo = zeros(size(Iblurred));
            doubleoppo(:,:,1) = filter2(do(:,:,1), Iblurred(:,:,1));
            doubleoppo(:,:,2) = filter2(do(:,:,2), Iblurred(:,:,2));
            doubleoppo(:,:,3) = filter2(do(:,:,3), Iblurred(:,:,3));
            doubleoppo = doubleoppo./max(doubleoppo(:));
            doubleoppogray = (doubleoppo(:,:,1) + doubleoppo(:,:,2)+ doubleoppo(:,:,3))/3;
            figure
            imagesc(doubleoppo);
            colormap(gray(256))
            figure
            imagesc(doubleoppogray);
            colormap(gray(256))
            if i == 1
                title('Filter output when LM channels focused on the far square')
            else
                title('Filter output when LM channels focused on the nearer square')
            end
        end
end