function h = MEAN(x)

n=256;

x = double(x);                        % Make input double
P = hist(x(:), n);                   % Compute N-bin histogram
P = P / sum(P(:));                 % Compute probabilities  

k = find(P);           

ENTROPHY = -sum(P(k) .* log2(P(k)));       % Compute entropy

 for i=1:8,
        
       for j=1:8,
           h (i,j)=ENTROPHY;
       end
 end