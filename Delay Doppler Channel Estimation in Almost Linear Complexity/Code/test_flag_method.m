close all
clear all
clc

N=199;
num_targets = 6;


tau   = randi(N,[1,num_targets]) - 1;
omega = randi(N,[1,num_targets]) - 1;

% alpha = rand(1,num_targets); alpha = alpha./norm(alpha);
mu = [0.2;0.8];
sigma = 0.005;
p = [0.3,0.7];
obj = gmdistribution(mu,sigma,p);
amp = obj.random(num_targets);
amp = abs(amp');
angles = 2*pi*rand(1,num_targets);
alpha = amp.*exp(angles*1i);
alpha = alpha/norm(alpha);
% PR seq
s_PR = randn(N,1)./sqrt(N);

slope_L = 0; p = 22;

if(isinf(slope_L))
    s_L = zeros(N,1); s_L(1) = 1;
else
    s_L = hseq_fn(slope_L,p,N);
end

s = (s_PR + s_L)/norm((s_PR + s_L));
R = pi_vect_fn(s,tau,omega,alpha);

% % Auto-correlation
% A = ambiguity_fn_fft(s, s, N);

% Receiver-Seq correlation 
A = ambiguity_fn_fft(R, s, N);

figure; mesh((0:N-1),(0:N-1),abs(A)); shading interp; caxis([-0.1 0.2]) 
SNR = 50;
threshold = 2/sqrt(N);
slope_M = inf;

% A_L_line = ambiguity_fn_fft_line(R, s, slope_M, N);
A_L_line = N*ifft(R.*conj(s));
I_L=find(abs(A_L_line)>threshold)
figure
stem(abs(A_L_line));
num_target = length(I_L);
for ii = 1:num_target
%    s_L = pi_vect_fn(s,0,I_L(ii)-1,N);
%    s_L = s_L/norm(s_L);
%    B_L_line = ambiguity_fn_fft_line(R,s_L,slope_L,N);
   R = R.*exp(2*pi*1i*(I_L(ii)-1)*(0:N-1)/N)';
   B_L_line = ambiguity_fn_fft_line_shifted(R,s,slope_L,N,I_L(ii)-1);
   figure,stem(abs(B_L_line)); 
    
end
    