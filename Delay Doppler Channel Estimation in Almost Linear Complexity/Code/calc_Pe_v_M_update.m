
close all
clear all
clc

N = 199;

num_targets = 2:20;

SNR_dB = 10
num_measurements = 50;

Pe_pr               = zeros(1,length(num_targets)); 
SNR_dB_rec_pr       = zeros(1,length(num_targets)); 
TA_pr               = zeros(1,length(num_targets)); 
DR_pr               = zeros(1,length(num_targets)); 


Pe_fast             = zeros(1,length(num_targets)); 
TA_fast             = zeros(1,length(num_targets)); 
DR_fast             = zeros(1,length(num_targets)); 
SNR_dB_rec_fast_L   = zeros(1,length(num_targets)); 
SNR_dB_rec_fast_M   = zeros(1,length(num_targets)); 

Pe_incidence             = zeros(1,length(num_targets));
TA_incidence             = zeros(1,length(num_targets)); 
DR_incidence             = zeros(1,length(num_targets)); 
SNR_dB_rec_incidence_L   = zeros(1,length(num_targets)); 
SNR_dB_rec_incidence_M   = zeros(1,length(num_targets)); 
SNR_dB_rec_incidence_N   = zeros(1,length(num_targets)); 

for ii = 1:length(num_targets) 
    
    num_targets(ii)
    
    sum_Pe_pr = 0;
    sum_TA_pr = 0;
    sum_DR_pr = 0;
    sum_SNR_dB_rec_pr = 0;
    
    sum_Pe_fast = 0;
    sum_TA_fast = 0;
    sum_DR_fast = 0;
    sum_SNR_dB_rec_fast_L = 0;
    sum_SNR_dB_rec_fast_M = 0;
    
    sum_Pe_incidence = 0;
    sum_TA_incidence = 0;
    sum_DR_incidence = 0;
    sum_SNR_dB_rec_incidence_L = 0;
    sum_SNR_dB_rec_incidence_M = 0;
    sum_SNR_dB_rec_incidence_N = 0;
      
    for jj = 1:num_measurements

        tau   = randi(N,[1,num_targets(ii)]) - 1;
        omega = randi(N,[1,num_targets(ii)]) - 1;
        alpha = rand(1,num_targets(ii)); alpha = alpha./norm(alpha);
%         
%         mu = [0.2;0.8];
%         sigma = 0.005;
%         p = [0.3,0.7];
%         obj = gmdistribution(mu,sigma,p);
%         amp = obj.random(num_targets(ii));
%         amp = abs(amp');
%         angles = 2*pi*rand(1,num_targets(ii));
%         alpha = amp.*exp(angles*1i);
%         alpha = alpha/norm(alpha);	        


        [TA,DR, SNR_dB_rec] = pr_radar_noise_update( tau,omega,alpha,SNR_dB,N );
        sum_Pe_pr = sum_Pe_pr +TA*DR;
        sum_TA_pr = sum_TA_pr +TA;
        sum_DR_pr = sum_DR_pr +DR;
        sum_SNR_dB_rec_pr = sum_SNR_dB_rec_pr + SNR_dB_rec;
        
        
        slope_L = randi(N)-1;
        slope_M = randi(N)-1;
        while(slope_M == slope_L)
            slope_M = randi(N)-1;
        end
        p = randi(N)-1; q = randi(N)-1;
        params = struct('slope_L',slope_L,'p',p,...
                        'slope_M',slope_M,'q',q);
        [TA,DR, SNR_dB_rec_L, SNR_dB_rec_M] = fast_radar_noise_new_update( tau,omega,alpha,SNR_dB,N, params ); 
        sum_Pe_fast = sum_Pe_fast +TA*DR;
        sum_TA_fast = sum_TA_fast +TA;
        sum_DR_fast = sum_DR_fast +DR;
        
        sum_SNR_dB_rec_fast_L = sum_SNR_dB_rec_fast_L + SNR_dB_rec_L;
        sum_SNR_dB_rec_fast_M = sum_SNR_dB_rec_fast_M + SNR_dB_rec_M;
        
        
        slope_N = randi(N)-1;
        while( (slope_N == slope_L) || (slope_N == slope_M))
            slope_N = randi(N)-1;
        end
        r = randi(N)-1;
        params = struct('slope_L',slope_L,'p',p,...
                        'slope_M',slope_M,'q',q,...
                        'slope_N',slope_N,'r',r);
       [TA,DR, SNR_dB_rec_L, SNR_dB_rec_M, SNR_dB_rec_N] = incidence_radar_noise_update( tau,omega,alpha,SNR_dB,N, params );
        sum_Pe_incidence = sum_Pe_incidence + TA*DR;
        sum_TA_incidence = sum_Pe_incidence + TA;
        sum_DR_incidence = sum_Pe_incidence + DR;
        sum_SNR_dB_rec_incidence_L = sum_SNR_dB_rec_incidence_L + SNR_dB_rec_L;
        sum_SNR_dB_rec_incidence_M = sum_SNR_dB_rec_incidence_M + SNR_dB_rec_M;
        sum_SNR_dB_rec_incidence_N = sum_SNR_dB_rec_incidence_N + SNR_dB_rec_N;

    end
    
    Pe_pr(ii) =  sum_Pe_pr/num_measurements;   
    TA_pr(ii) =  sum_TA_pr/num_measurements;  
    DR_pr(ii) =  sum_DR_pr/num_measurements;  
    SNR_dB_rec_pr(ii) =  sum_SNR_dB_rec_pr/num_measurements;      
    
    Pe_fast(ii) = sum_Pe_fast/num_measurements;
    TA_fast(ii) = sum_TA_fast/num_measurements;
    DR_fast(ii) = sum_DR_fast/num_measurements;  
    SNR_dB_rec_fast_L(ii) = sum_SNR_dB_rec_fast_L/num_measurements;   
    SNR_dB_rec_fast_M(ii) = sum_SNR_dB_rec_fast_M/num_measurements;    
    
    Pe_incidence(ii) = sum_Pe_incidence/num_measurements;
    TA_incidence(ii) = sum_TA_incidence/num_measurements;
    DR_incidence(ii) = sum_DR_incidence/num_measurements;
    SNR_dB_rec_incidence_L(ii) = sum_SNR_dB_rec_incidence_L/num_measurements;   
    SNR_dB_rec_incidence_M(ii) = sum_SNR_dB_rec_incidence_M/num_measurements;  
    SNR_dB_rec_incidence_N(ii) = sum_SNR_dB_rec_incidence_N/num_measurements;  
    
end

Pe_pr  
TA_pr
DR_pr
SNR_dB_rec_pr ;      

Pe_fast   
TA_fast
DR_fast
SNR_dB_rec_fast_L ;  
SNR_dB_rec_fast_M ;   

Pe_incidence
TA_incidence
DR_incidence
SNR_dB_rec_incidence_L;
SNR_dB_rec_incidence_M;
SNR_dB_rec_incidence_N;


