function [A] = ambiguity_fn(f, g, N)

f = f(:);
g = g(:);

assert((length(f)==N) && (length(g)==N));

tau = 0:N-1;
omega = 0:N-1;

A = zeros(N,N);

for i = 1:length(tau)
    for j = 1:length(omega)
        
        pi_g = exp( -(2.*pi.*1i./N).*tau(i).*omega(i).*(N-1)./2 ) .*pi_fn(g, tau(i), omega(j));
        A(i,j) = f'*pi_g;
        
    end
end

end
