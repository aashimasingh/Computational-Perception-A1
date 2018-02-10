
function f = make2DGaussian(N,sigma)
  % N is grid size, sigma is stdev of Gaussian
  %
  % Make sure that N is much bigger than sigma so that the Gaussian
  % tail is close to 0.  
  %
  [x y] = meshgrid(round(-N/2)+1:round(N/2), round(-N/2)+1:round(N/2));
  f = exp(- (x.^2 + y.^2) / (2*sigma^2));
  f = f./sum(f(:));