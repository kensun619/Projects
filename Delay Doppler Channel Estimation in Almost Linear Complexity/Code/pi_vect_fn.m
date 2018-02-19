function [pi_f] = pi_vect_fn(f, tau, omega, alpha)

f = f(:);
m = length(tau);
assert(m==length(omega));
assert(m==length(alpha));

pi_f = 0;
for ii=1:m
    pi_f = pi_f + alpha(ii)*pi_fn(f,tau(ii),omega(ii)); 
end

end