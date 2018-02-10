function I = makeImageCheckerboard(N)
    I = .01 * ones(N, N, 3);

    step = N/8; 
    for i1 = 0:7
      for j1 = 0:7
        r = rand;
        g = rand;
        b = 0; %rand;
        I(step*i1 + 1 : step*(i1+1), step*j1 + 1 : step*(j1+1),  1) =  r;
        I(step*i1 + 1 : step*(i1+1), step*j1 + 1 : step*(j1+1),  2) =  g;
        I(step*i1 + 1 : step*(i1+1), step*j1 + 1 : step*(j1+1),  3) =  b;
      end
    end
