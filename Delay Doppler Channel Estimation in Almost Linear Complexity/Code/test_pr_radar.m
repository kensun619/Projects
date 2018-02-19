close all
clear all
clc

N=199;

tau_1=50;
omega_1=60;
alpha_1=0.35;

tau_2=150;
omega_2=160;
alpha_2=0.65;

tau=[tau_1 tau_2];
omega=[omega_1 omega_2];
alpha=[alpha_1,alpha_2];

% PR seq
s = randn(N,1)./sqrt(N);

R = pi_vect_fn(s,tau,omega,alpha);

% % Auto-correlation
% A = ambiguity_fn_fft(s, s, N);

% Receiver-Seq correlation 
A = ambiguity_fn_fft(R, s, N);

figure; mesh((0:N-1),(0:N-1),abs(A)); shading interp; caxis([-0.1 0.2]) 

[r,c,~] = find(abs(A)>0.3)

for ii=1:length(tau)
    tau_omega_answer = [r(ii)-1 c(ii)-1]
end

