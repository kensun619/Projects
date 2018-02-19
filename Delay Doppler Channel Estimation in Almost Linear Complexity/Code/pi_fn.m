function [pi_f] = pi_fn(f, tau, omega)

f = f(:);

N = length(f);

n = (0:N-1)';

pi_f = exp( 1i.*2.*pi.*omega*n/N ).*circshift(f, -tau);

end