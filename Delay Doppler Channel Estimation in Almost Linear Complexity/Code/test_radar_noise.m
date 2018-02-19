
close all
clear all
clc

N = 199;

num_targets = 7;

tau   = randi(N,[1,num_targets]) - 1
omega = randi(N,[1,num_targets]) - 1
alpha = rand(1,num_targets); alpha = alpha./norm(alpha)

SNR_dB = 0

%
% [error, ~] = pr_radar_noise( tau,omega,alpha,SNR_dB,N )


slope_L = randi(N)-1;
slope_M = randi(N)-1;
while(slope_M == slope_L)
    slope_M = randi(N)-1;
end
p = randi(N)-1; q = randi(N)-1;
params = struct('slope_L',slope_L,'p',p,...
                'slope_M',slope_M,'q',q);
% [error, ~, ~] = fast_radar_noise( tau,omega,alpha,SNR_dB,N, params )
[TA,DR,~,~] = fast_radar_noise_new_update( tau,omega,alpha,SNR_dB,N, params ) ;

slope_N = randi(N)-1;
while( (slope_N == slope_L) || (slope_N == slope_M))
    slope_N = randi(N)-1;
end
r = randi(N)-1;
params = struct('slope_L',slope_L,'p',p,...
                'slope_M',slope_M,'q',q,...
                'slope_N',slope_N,'r',r,...
                'display',true);
%[error, ~, ~, ~] = incidence_radar_noise( tau,omega,alpha,SNR_dB,N, params )
[TA,DR,~, ~, ~] = incidence_radar_noise_update( tau,omega,alpha,SNR_dB,N, params )
