function I = makeImageSquare(N,i);
    start = (N-i)/2;

    I = .5*ones(N, N, 3);
    for j = 1:3
        %I(N/4 +1 : 3*N/4 , N/4 +1 : 3*N/4,   j) =  .99*ones(N/2,N/2) ; 
        I(start + 1: start + i,start + 1: start + i, j) = .99*ones(i,i) ;
    end