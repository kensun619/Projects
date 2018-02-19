
close all
clear all
clc

N = 199;

num_targets = 4;

SNR_dB = 50;
num_measurements = 100;


Pe_fast             = zeros(1,length(num_targets)); 
SNR_dB_rec_fast_L   = zeros(1,length(num_targets)); 
SNR_dB_rec_fast_M   = zeros(1,length(num_targets)); 
Pe_incidence             = zeros(1,length(num_targets)); 
SNR_dB_rec_incidence_L   = zeros(1,length(num_targets)); 
SNR_dB_rec_incidence_M   = zeros(1,length(num_targets)); 
SNR_dB_rec_incidence_N   = zeros(1,length(num_targets)); 

for ii = 1:length(num_targets) 
    
    num_targets(ii)
    
    
    sum_Pe_fast = 0;
    sum_SNR_dB_rec_fast_L = 0;
    sum_SNR_dB_rec_fast_M = 0;
    
    sum_Pe_incidence = 0;
    sum_SNR_dB_rec_incidence_L = 0;
    sum_SNR_dB_rec_incidence_M = 0;
    sum_SNR_dB_rec_incidence_N = 0;
    
    
    for jj = 1:num_measurements

        tau   = randi(N,[1,num_targets(ii)]) - 1;
        omega = randi(N,[1,num_targets(ii)]) - 1;
        alpha = rand(1,num_targets(ii)); alpha = alpha./norm(alpha);

        
        slope_L = randi(N)-1;
        slope_M = randi(N)-1;
        while(slope_M == slope_L)
            slope_M = randi(N)-1;
        end
                slope_N = randi(N)-1;
        while( (slope_N == slope_L) || (slope_N == slope_M))
            slope_N = randi(N)-1;
        end
        r = randi(N)-1;       
        
        p = randi(N)-1; q = randi(N)-1;
        
        
        slope_L = 0;
        slope_M = 1;
        slope_N = 2;
        params = struct('slope_L',slope_L,'p',p,...
                        'slope_M',slope_M,'q',q);
        [error, SNR_dB_rec_L, SNR_dB_rec_M] = fast_radar_noise( tau,omega,alpha,SNR_dB,N, params );
        sum_Pe_fast = sum_Pe_fast + error;
        sum_SNR_dB_rec_fast_L = sum_SNR_dB_rec_fast_L + SNR_dB_rec_L;
        sum_SNR_dB_rec_fast_M = sum_SNR_dB_rec_fast_M + SNR_dB_rec_M;
        
        cross_error = error;

        params = struct('slope_L',slope_L,'p',p,...
                        'slope_M',slope_M,'q',q,...
                        'slope_N',slope_N,'r',r);
        [error, SNR_dB_rec_L, SNR_dB_rec_M, SNR_dB_rec_N] = incidence_radar_noise( tau,omega,alpha,SNR_dB,N, params );
        sum_Pe_incidence = sum_Pe_incidence + error;
        sum_SNR_dB_rec_incidence_L = sum_SNR_dB_rec_incidence_L + SNR_dB_rec_L;
        sum_SNR_dB_rec_incidence_M = sum_SNR_dB_rec_incidence_M + SNR_dB_rec_M;
        sum_SNR_dB_rec_incidence_N = sum_SNR_dB_rec_incidence_N + SNR_dB_rec_N;
        incidence_error = error;
        
        if incidence_error == 1 && cross_error == 0
            error_case = struct('tau',tau,'omega',omega,'alpha',alpha,'slope_L',slope_L,'slope_M',slope_M,'slope_N',slope_N,'p',p,'q',q,'r',r);
            error('error case');
        end
    end
    
    Pe_pr(ii) =  sum_Pe_pr/num_measurements;         
    SNR_dB_rec_pr(ii) =  sum_SNR_dB_rec_pr/num_measurements;      
    
    Pe_fast(ii) = sum_Pe_fast/num_measurements;             
    SNR_dB_rec_fast_L(ii) = sum_SNR_dB_rec_fast_L/num_measurements;   
    SNR_dB_rec_fast_M(ii) = sum_SNR_dB_rec_fast_M/num_measurements;    
    
    Pe_incidence(ii) = sum_Pe_incidence/num_measurements;             
    SNR_dB_rec_incidence_L(ii) = sum_SNR_dB_rec_incidence_L/num_measurements;   
    SNR_dB_rec_incidence_M(ii) = sum_SNR_dB_rec_incidence_M/num_measurements;  
    SNR_dB_rec_incidence_N(ii) = sum_SNR_dB_rec_incidence_N/num_measurements;  
    
end

Pe_pr        
SNR_dB_rec_pr       

Pe_fast             
SNR_dB_rec_fast_L   
SNR_dB_rec_fast_M    

Pe_incidence
SNR_dB_rec_incidence_L
SNR_dB_rec_incidence_M
SNR_dB_rec_incidence_N


