close all
clear

N = 256;
%standard deviations are similar
sigma1 = 8;
sigma2 = 8.5;
f1 = make2DGaussian(N, sigma1);
f2 = make2DGaussian(N, sigma2);
%computing the DOG
f = f1 - f2;
kx = 0;

rmstot = zeros(1,100);
rmstot2 = zeros(1,48);
size(rmstot)
question = 'b';
switch question
    case 'a'
        kx = linspace(0,24);
        for i = 1:100
        I = mk2Dcosine(N,kx(i),0);
        %convolve image with DOG filter
        Y = filter2(f,I);
        rmstot(1,i) = rms(Y(:));
        end
        figure
        %plot RMS and spatial frequency
        plot(kx, rmstot);
        ylabel('RMS');
        xlabel('spatial frequency');
        indexmax = find(max(rmstot)==rmstot);
        
        xmax = kx(indexmax);
        ymax = rmstot(indexmax);
        strmax = ['Freq = ' ,num2str(xmax)];
        text(xmax,ymax,strmax);
    case 'b'
        width = [1:1:48];
        for i = 1:48
            %create image with increasing width
            I = makeImageSquare(N,i);
            Y = (filter2(f,I(:,:,1)) + filter2(f,I(:,:,2)) + filter2(f,I(:,:,3)))/3;
            if mod(i,8) == 0
            figure
            imagesc(Y)
            title(i)
            colormap(gray(256))
            end
            rmstot2(1,i) = rms(Y(:));
        end
        figure
        plot(width, rmstot2);
        ylabel('RMS');
        xlabel('square width');
        indexmax = find(max(rmstot2)==rmstot2);
        
        xmax = width(indexmax);
        ymax = rmstot2(indexmax);
        %plot the optimal frequency
        strmax = ['Freq = ' ,num2str(xmax)];
        text(xmax,ymax,strmax);
        
end
