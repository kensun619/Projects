% Generate Heisenberg sequence
%c = slop; b = # in Z_N

function [f] = hseq_fn(c,b,N)

n = (0:N-1)';

f = (1/sqrt(N)) .* exp( (2.*pi.*1i./N).*( ( -(N+1)./2).*c.*n.^2 + b.*n ) );

f = f(:);

end