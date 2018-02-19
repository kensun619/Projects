function [A] = ambiguity_fn_fft(f, g, N)

f = f(:);
g = g(:);

assert((length(f)==N) && (length(g)==N));

tau = 0:N-1;
omega = 0:N-1;

A = zeros(N,N);

for i = 1:length(tau)
    A(i,:) = N*ifft(circshift(g,-tau(i)).*conj(f));
end

% for j = 1:length(omega)
%     A(:,j) = conj (ifft( fft(-f.*exp(-1i.*2.*pi.*omega(j).*(0:N-1)'./N)) .* conj(fft(-g)) ));
% end

end
