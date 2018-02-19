function Sa = generateBasis(a,b,N)
n = 0:N-1;
nn = n.*n*(N-1)/2*a+b*n;

Sa = exp(2*pi*1i*nn/N)./sqrt(N);