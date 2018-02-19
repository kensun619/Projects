
function [error, SNR_dB_rec_L, SNR_dB_rec_M] = fast_radar_noise_update(tau,omega,alpha,SNR_dB,N, params)

if isfield(params, 'display')
    displayAm = params.display;
else
    displayAm = 0;
end

num_targets = length(tau);

SNR = 10^(SNR_dB/10);

sigma = sqrt(10^(-SNR_dB/10));

slope_L = params.slope_L; p = params.p;
assert(~isinf(slope_L));
s_L = hseq_fn(slope_L,p,N);

slope_M = params.slope_M; q = params.q;
assert(~isinf(slope_M));
s_M = hseq_fn(slope_M,q,N);

signal_L = pi_vect_fn(s_L,tau,omega,alpha);
noise_L = (sigma./sqrt(N)).*randn(N,1);
R_L = signal_L + noise_L;
SNR_dB_rec_L = 10*log10( (signal_L'*signal_L)/(noise_L'*noise_L) );

signal_M = pi_vect_fn(s_M,tau,omega,alpha);
noise_M = (sigma./sqrt(N)).*randn(N,1);
R_M = signal_M + noise_M;
SNR_dB_rec_M = 10*log10( (signal_M'*signal_M)/(noise_M'*noise_M) );

% % Auto-correlation
% A_L = ambiguity_fn(s_L, s_L, N);
% A_M = ambiguity_fn(s_M, s_M, N);

% Receiver-Chirp correlation 

if displayAm
    A_L = ambiguity_fn(R_L, s_L, N);
    A_M = ambiguity_fn(R_M, s_M, N);

    A = abs(A_L)+abs(A_M);

    figure; mesh((0:N-1),(0:N-1),abs(A_L)); shading interp; caxis([-0.1 0.2]) 
    figure; mesh((0:N-1),(0:N-1),abs(A_M)); shading interp; caxis([-0.1 0.2]) 
    figure; mesh((0:N-1),(0:N-1),abs(A));   shading interp; caxis([-0.1 0.2]) 
end
% DECODING STARTS %%%%%%%%%%%%%%%%%%%%%%

SNR;

[pair_candidates, len_x, len_y] = get_candidates(R_L, s_L, slope_L, R_M, s_M, slope_M, SNR, N);

pair_candidates;

amp_candidates = zeros(1,len_x*len_y);
for ii=1:len_x*len_y
    Amp_1 = R_L(:)'*( exp( -(2.*pi.*1i./N).*pair_candidates(1,ii).*pair_candidates(2,ii).*(N-1)./2 ) .*pi_fn(s_L(:), pair_candidates(1,ii), pair_candidates(2,ii)) );
    Amp_2 = R_M(:)'*( exp( -(2.*pi.*1i./N).*pair_candidates(1,ii).*pair_candidates(2,ii).*(N-1)./2 ) .*pi_fn(s_M(:), pair_candidates(1,ii), pair_candidates(2,ii)) );
    
    amp_candidates(ii) = abs(Amp_1-Amp_2);
end

[amp_candidates, I] =sort(amp_candidates); pair_candidates(1,:) = pair_candidates(1,I); pair_candidates(2,:) = pair_candidates(2,I);

num_dec_targets = max(len_x,len_y);

num_dec_targets;
pair_candidates;

tau_dec = zeros(1,num_dec_targets);
omega_dec = zeros(1,num_dec_targets);

if(~isempty(pair_candidates))
    tau_dec = pair_candidates(1,1:num_dec_targets);
    omega_dec = pair_candidates(2,1:num_dec_targets);
end

% DECODING ENDS %%%%%%%%%%%%%%%%%%%%%%%

if(  length(tau_dec) ~= length(tau) )
    error = 1;
    return
end

%check errors in decoding
% [tau,I] = sort(tau); omega = omega(I)
% [tau_dec,I] = sort(tau_dec); omega_dec = omega_dec(I)
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


C = intersect(true,dec,'rows'); % intersection between two sets

num_correct_targets = length(C);
DR = num_correct_targets/num_targets;

TA = num_correct_targets/	;
