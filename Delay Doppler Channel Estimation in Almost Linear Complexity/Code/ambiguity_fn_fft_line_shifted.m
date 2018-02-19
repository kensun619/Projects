function [A_line] = ambiguity_fn_fft_line_shifted(f, g, c, N, omega)

f = f(:);
g = g(:);

assert( (length(f)==N) && (length(g)==N) );
cof = exp(-2*pi*1i/N*(0:N-1)*omega)';
cof = [cof(1);cof(N+1-(1:N-1))];
f = weil(f,c,N);
f = [f(1);f(N+1-(1:N-1))];

g = weil(g,c,N);

A_line = fft( f , N ) .* fft( conj(g) , N );
A_line = ifft( A_line , N );

end