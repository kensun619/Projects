
function [TA,DR, SNR_dB_rec_L, SNR_dB_rec_M, SNR_dB_rec_N] = incidence_radar_noise_update(tau, omega, alpha, SNR_dB, N, params)

if isfield(params, 'display')
    displayAm = params.display;
else
    displayAm = 0;
end

num_targets = length(tau);

SNR = 10^(SNR_dB/10);

sigma = sqrt(10^(-SNR_dB/10));

slope_L = params.slope_L; p = params.p;
assert ( ~isinf(slope_L) );
s_L = hseq_fn(slope_L,p,N);

slope_M = params.slope_M; q = params.q;
assert( ~isinf(slope_M) );
s_M = hseq_fn(slope_M,q,N);

slope_N = params.slope_N; r = params.r;
assert( ~isinf(slope_N) );
s_N = hseq_fn(slope_N,r,N);

signal_L = pi_vect_fn(s_L,tau,omega,alpha);
noise_L = (sigma./sqrt(N)).*randn(N,1);
R_L = signal_L + noise_L;
SNR_dB_rec_L = 10*log10( (signal_L'*signal_L)/(noise_L'*noise_L) );

signal_M = pi_vect_fn(s_M,tau,omega,alpha);
noise_M = (sigma./sqrt(N)).*randn(N,1);
R_M = signal_M + noise_M;
SNR_dB_rec_M = 10*log10( (signal_M'*signal_M)/(noise_M'*noise_M) );

signal_N = pi_vect_fn(s_N,tau,omega,alpha);
noise_N = (sigma./sqrt(N)).*randn(N,1);
R_N = signal_N + noise_N;
SNR_dB_rec_N = 10*log10( (signal_N'*signal_N)/(noise_N'*noise_N) );

% % Auto-correlation
% A_L = ambiguity_fn(s_L, s_L, N);
% A_M = ambiguity_fn(s_M, s_M, N);
% A_N = ambiguity_fn(s_N, s_N, N);

% % Receiver-Chirp correlation 
% if displayAm
%     A_L = ambiguity_fn(R_L, s_L, N);
%     A_M = ambiguity_fn(R_M, s_M, N);
%     A_N = ambiguity_fn(R_N, s_N, N);
% 
%     A = abs(A_L)+abs(A_M)+abs(A_N);
% 
%     figure; mesh((0:N-1),(0:N-1),abs(A_L)); shading interp; caxis([-0.1 0.2]) 
%     figure; mesh((0:N-1),(0:N-1),abs(A_M)); shading interp; caxis([-0.1 0.2]) 
%     figure; mesh((0:N-1),(0:N-1),abs(A_N)); shading interp; caxis([-0.1 0.2]) 
%     figure; mesh((0:N-1),(0:N-1),abs(A)); shading interp; caxis([-0.1 0.2]) 
% end
% DECODING STARTS %%%%%%%%%%%%%%%%%%%%%%

SNR;

[pair_candidates_LM, ~, ~] = get_candidates(R_L, s_L, slope_L, R_M, s_M, slope_M, SNR, N);
[pair_candidates_LN, ~, ~] = get_candidates(R_L, s_L, slope_L, R_N, s_N, slope_N, SNR, N);
[pair_candidates_MN, ~, ~] = get_candidates(R_M, s_M, slope_M, R_N, s_N, slope_N, SNR, N);

pair_intersect = intersect(pair_candidates_LM',pair_candidates_LN', 'rows');
pair_intersect = intersect(pair_intersect, pair_candidates_MN','rows');
pair_intersect = pair_intersect';

tau_dec = pair_intersect(1,:);
omega_dec = pair_intersect(2,:);

tau_dec;
omega_dec;

% DECODING ENDS %%%%%%%%%%%%%%%%%%%%%%%


%check errors in decoding
% [tau,I] = sort(tau); omega = omega(I);
% [tau_dec,I] = sort(tau_dec); omega_dec = omega_dec(I);
% 
% tau_match = (tau == tau_dec); omega_match = (omega == omega_dec);
% 
% if( all(tau_match) && all(omega_match) )
%     error = 0;
% else
%     error = 1;
% end  

true = [tau; omega]; true = sortrows(true');
dec = [tau_dec; omega_dec]; dec = sortrows(dec');

C = intersect(true,dec,'rows');
num_correct_targets = size(C,1);
DR = num_correct_targets/num_targets;
num_dec_targets = length(tau_dec);
if num_dec_targets == 0
    TA = 0;
else
    TA = num_correct_targets/num_dec_targets;
end


