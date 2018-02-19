function [TA,DR, SNR_dB_rec_L, SNR_dB_rec_M, tau_dec, omega_dec] = fast_radar_noise_new_update(tau,omega,alpha,SNR_dB,N,param)



if isfield(param, 'display')
    displayAm = param.display;
else
    displayAm = 0;
end


display_full_ambiguity = false;
num_targets = length(tau);

SNR = 10^(SNR_dB/10);

sigma = sqrt(10^(-SNR_dB/10));

% generate Chirp given param

slope_L = param.slope_L;
p = param.p;
slope_M = param.slope_M;
q = param.q;
if slope_L == Inf
    v_L = [1;0];
else
    v_L = [1;slope_L];
end
if slope_M == Inf
    v_M = [1;0];
else
    v_M = [1;slope_M];
end
    s_L = generateBasis(slope_L,p,N);
s_M = generateBasis(slope_M,q,N);

% display
if displayAm
    num_targets
    v_L
    v_M
end

signal_L = pi_vect_fn(s_L,tau,omega,alpha);
noise_L = (sigma./sqrt(N)).*randn(N,1);
R_L = signal_L + noise_L;
% R_L = signal_L;
SNR_dB_rec_L = 10*log10( (signal_L'*signal_L)/(noise_L'*noise_L) );

signal_M = pi_vect_fn(s_M,tau,omega,alpha);
noise_M = (sigma./sqrt(N)).*randn(N,1);
R_M = signal_M + noise_M;
% R_M = signal_M;
SNR_dB_rec_M = 10*log10( (signal_M'*signal_M)/(noise_M'*noise_M) );

%% Auto-correlation
% A_L = ambiguity_fn(s_L, s_L, N);
% A_M = ambiguity_fn(s_M, s_M, N);

% % Full Receiver-Chirp correlation
if displayAm
    A_L = ambiguity_fn(R_L, s_L, N);
    A_M = ambiguity_fn(R_M, s_M, N);

    A = abs(A_L)+abs(A_M);

    figure; mesh((0:N-1),(0:N-1),abs(A_L)); shading interp; caxis([-0.1 0.2]) 
    figure; mesh((0:N-1),(0:N-1),abs(A_M)); shading interp; caxis([-0.1 0.2]) 
    figure; mesh((0:N-1),(0:N-1),abs(A)); shading interp; caxis([-0.1 0.2]) 
end
% Detection

% th = max ( [ (1/sqrt(SNR))*0.25 , 0.005] );
th = 3* sqrt(3*log10(log10(N))/(N*SNR));

if( isinf(slope_M) )
    A_L_line = N*ifft(s_L.*conj(R_L)); %A_L_line = fft(R_L.*conj(s_L));
else
    A_L_line = ambiguity_fn_fft_line(R_L, s_L, slope_M, N);
end
I_L=find(abs(A_L_line)>th);
b=A_L_line(I_L);
y=I_L-1;

if( isinf(slope_L) )
    A_M_line = N*ifft(s_M.*conj(R_M)); %A_M_line = fft(R_M.*conj(s_M));
else
    A_M_line = ambiguity_fn_fft_line(R_M, s_M, slope_L, N);
end
I_M=find(abs(A_M_line)>th);
a=A_M_line(I_M);
x=I_M-1;

num_dec_targets_L = length(I_L); % on Line M
num_dec_targets_M = length(I_M); % on Line L

if num_dec_targets_L == 0 || num_dec_targets_M ==0
    TA = 0;
    DR = 0;
    return
end

if displayAm
    figure;
    num_dec_targets_L
    num_dec_targets_M
    subplot(2,1,1); stem((0:N-1),abs(A_L_line)); title('On M Line');
    subplot(2,1,2); stem((0:N-1),abs(A_M_line)); title('On L Line');
end

h = zeros(num_dec_targets_L*num_dec_targets_M,1);
idx = 1;
tau_candidate = zeros(num_dec_targets_L*num_dec_targets_M,1);
omega_candidate = zeros(num_dec_targets_L*num_dec_targets_M,1);
for u = 1:num_dec_targets_L
    for v = 1:num_dec_targets_M
        M = [x(v)*v_L';y(u)*v_M'];
        h(idx) = (exp(-2*pi*1i*x(v)*p/N)*b(u)*exp(-2*pi*1i*det(M)/N)-exp(-2*pi*1i*y(u)*q/N)*a(v)); % h(l,m)=A(R_{L},C_{L})[m]??_{M}[m]-A(R_{M},C_{M})[l]?e(?[l,m])??_{L}[l]
        tau_candidate(idx) = x(v);
        omega_candidate(idx) = y(u);
        idx = idx+1;
    end
end



[h_abs, I] = sort(abs(h));
tau_candidate = tau_candidate(I)';
omega_candidate = omega_candidate(I)';

num_dec_targets = max( num_dec_targets_L,num_dec_targets_M);
tau_tmp = tau_candidate(1:num_dec_targets);
omega_tmp = omega_candidate(1:num_dec_targets);



tau_dec = mod(tau_tmp*v_L(1) + omega_tmp*v_M(1),N);
omega_dec =  mod(tau_tmp*v_L(2) + omega_tmp*v_M(2),N);
if displayAm
    tau_dec
    omega_dec
    h_abs
end
%check errors in decoding
true = [tau; omega]; true = sortrows(true');
dec = [tau_dec; omega_dec]; dec = sortrows(dec');
C = intersect(true,dec,'rows');
num_correct_targets = size(C,1);
DR = num_correct_targets/num_targets;

TA = num_correct_targets/num_dec_targets;

