function [A_line] = ambiguity_fn_fft_line(f, g, c, N)

f = f(:);
g = g(:);

assert( (length(f)==N) && (length(g)==N) );

f = weil(f,c,N);
f = [f(1);f(N+1-(1:N-1))];

g = weil(g,c,N);

A_line = fft( f , N ) .* fft( conj(g) , N );
A_line = ifft( A_line , N );

end