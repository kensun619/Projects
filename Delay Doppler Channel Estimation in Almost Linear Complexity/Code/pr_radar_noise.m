
function [error, SNR_dB_rec] = pr_radar_noise(tau,omega,alpha,SNR_dB,N)

num_targets = length(tau);

SNR = 10^(SNR_dB/10);

sigma = sqrt(10^(-SNR_dB/10));

% PR seq
s = randn(N,1)./sqrt(N);

signal = pi_vect_fn(s,tau,omega,alpha);
noise = (sigma./sqrt(N)).*randn(N,1);

R = signal + noise;

SNR_dB_rec = 10*log10( (signal'*signal)/(noise'*noise) );

% % Auto-correlation
% A = ambiguity_fn_fft(s, s, N);

% Receiver-Seq correlation 
A = ambiguity_fn_fft(R, s, N);

%figure; mesh((0:N-1),(0:N-1),abs(A)); shading interp; caxis([-0.1 0.2]) 

threshold = min( [ 0.30+(1/SNR)*0.05 , 0.9 ] );

[r,c,~] = find(abs(A)>threshold);

num_dec_targets = length(r);

%check mismatch
if( num_targets ~= num_dec_targets )
   error = 1;
   return
end

tau_dec = zeros(1,num_dec_targets);
omega_dec = zeros(1,num_dec_targets);
for ii=1:num_dec_targets
    tau_dec(ii) = r(ii)-1;
    omega_dec(ii) = c(ii)-1;
end

% tau_dec
% omega_dec

%check errors in decoding
[tau,I] = sort(tau); omega = omega(I);
[tau_dec,I] = sort(tau_dec); omega_dec = omega_dec(I);

tau_match = (tau == tau_dec); omega_match = (omega == omega_dec);

if( all(tau_match) && all(omega_match) )
    error = 0;
else
    error = 1;
end    



