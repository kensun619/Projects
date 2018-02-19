
function [TA,DR, SNR_dB_rec] = pr_radar_noise_update(tau,omega,alpha,SNR_dB,N)

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

% threshold = min( [ 0.30+(1/SNR)*0.05 , 0.9 ] );
threshold = 3*sqrt(3*log10(log10(N))/(N*SNR));

[r,c,~] = find(abs(A)>threshold);

num_dec_targets = length(r);


tau_dec = zeros(1,num_dec_targets);
omega_dec = zeros(1,num_dec_targets);
for ii=1:num_dec_targets
    tau_dec(ii) = r(ii)-1;
    omega_dec(ii) = c(ii)-1;
end

% tau_dec
% omega_dec

%check errors in decoding
% the ground truth for targets
true = [tau; omega]; true = sortrows(true');

% targets dectected by this method
dec = [tau_dec; omega_dec]; dec = sortrows(dec');


C = intersect(true,dec,'rows'); % intersection between two sets

num_correct_targets = size(C,1);
DR = num_correct_targets/num_targets;
if num_dec_targets == 0
    TA = 0;
else
    TA = num_correct_targets/num_dec_targets;
end

