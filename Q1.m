
%   Q1.m
%
%   COMP 546,  Winter 2018
%   Assignment 1 

close all
clear

question = 'a';
N = 256;
switch question
    case 'a'
        I =  makeImageCheckerboard(N);
        figure
        image(I);
        
        %  put a shadow on the right side of the image
        
        for k = 1:3
            I( :, N/2 +1 : N,  k) =  I(: , N/2 +1 : N,  k) * 0.2 ;
        end
        figure
        image(I);
    case 'b'
        I =  makeImageSimultaneousContrast(N);
        figure
        image(I);
    case 'c'
        I =  imread('Whites_illusion.jpg');
        figure
        image(I);
end       

%%

%  Here we define the intensity, red-green, and blue-yellow axes
%  These are unit vectors;

R = squeeze( double( I(:,:,1) ) );      %  read up on what 'squeeze' does
G = squeeze( double( I(:,:,2) ) );
B = squeeze( double( I(:,:,3) ) );
intensity = (R + G + B)/3;

%%  Compute local contrast

sig_localmean = 30;   %  Arbitrarily chosen value.   

Rlocalmean  = imgaussfilt( R, sig_localmean ); 
Glocalmean  = imgaussfilt( G, sig_localmean );
Blocalmean  = imgaussfilt( B, sig_localmean );
intensityLocalMean = (Rlocalmean + Glocalmean + Blocalmean)/3;
localcontrast  =   (intensity - intensityLocalMean) ./ intensityLocalMean;

figure
imagesc(intensity);
colormap(gray(256)), colorbar
title('intensity')

figure
imagesc(intensityLocalMean);
colormap(gray(256)), colorbar
title('intensityLocalMean')

figure
imagesc(localcontrast);  
colormap(gray(256)), colorbar
title('localcontrast')

%%
%single opponency 
O = R - G;
Olocalmean = imgaussfilt(O, sig_localmean);
so = (O - Olocalmean) ./ (1+Olocalmean);

figure
imagesc(so);
colormap(gray(256)), colorbar
title('single opponency')


