% simulation

clc
clear all

N = [199, 401, 797, 997, 1499, 2503, 4001];
t1 = sqrt(N);
t2 = N.^(1/3);
t3 = N.^0.4;
num_targets = floor([t1;t2;t3]);
SNR_dB = [0, 5, 10];
num_measurements = 100;
result_pr = zeros(length(SNR_dB),size(num_targets,1),length(N));
result_cross = zeros(length(SNR_dB),size(num_targets,1),length(N));
result_incidence = zeros(length(SNR_dB),size(num_targets,1),length(N));
for n = 1:length(N)
    for snr = 1:length(SNR_dB)
        for ii = 1:1:size(num_targets,1)
            n
            snr;
            ii;
            sum_TA_pr = 0;
            sum_DR_pr = 0;    
            sum_Pe_pr = 0;

            sum_Pe_fast = 0;
            sum_TA_fast = 0;
            sum_DR_fast = 0;


            sum_Pe_incidence = 0;
            sum_TA_incidence = 0;
            sum_DR_incidence = 0;
            
            for m = 1:num_measurements
                
                tau   = randi(N(n),[1,num_targets(ii,n)]) - 1;
                omega = randi(N(n),[1,num_targets(ii,n)]) - 1;
                % Uniform alpha
                alpha = rand(1,num_targets(ii,n)); alpha = alpha./norm(alpha);

                [TA,DR, SNR_dB_rec] = pr_radar_noise_update( tau,omega,alpha,SNR_dB(snr),N(n) ); 
                TA;
                DR;
                sum_Pe_pr = sum_Pe_pr + TA*DR;
                sum_TA_pr = sum_TA_pr +TA;
                sum_DR_pr = sum_DR_pr +DR;
                
                slope_L = randi(N(n))-1;
                slope_M = randi(N(n))-1;
                while(slope_M == slope_L)
                    slope_M = randi(N(n))-1;
                end
                p = randi(N(n))-1; q = randi(N(n))-1;
                params = struct('slope_L',slope_L,'p',p,...
                                'slope_M',slope_M,'q',q);

                [TA,DR, ~,~] = fast_radar_noise_new_update( tau,omega,alpha,SNR_dB(snr),N(n), params );           
                sum_Pe_fast = sum_Pe_fast + TA*DR;
                sum_TA_fast = sum_TA_fast +TA;
                sum_DR_fast = sum_DR_fast +DR;
                TA;
                DR;
                
                slope_N = randi(N(n))-1;
                while( (slope_N == slope_L) || (slope_N == slope_M))
                    slope_N = randi(N(n))-1;
                end
                r = randi(N(n))-1;
                params = struct('slope_L',slope_L,'p',p,...
                                'slope_M',slope_M,'q',q,...
                                'slope_N',slope_N,'r',r);
                [TA,DR, ~,~,~] = incidence_radar_noise_update( tau,omega,alpha,SNR_dB(snr),N(n), params );
                sum_Pe_incidence = sum_Pe_incidence + TA*DR;
                sum_TA_incidence = sum_Pe_incidence + TA;
                sum_DR_incidence = sum_Pe_incidence + DR;
                TA;
                DR;
            end
            result_pr(snr,ii,n) = sum_Pe_pr/num_measurements;
            result_cross(snr,ii,n) = sum_Pe_fast/num_measurements  ;         
            result_incidence(snr,ii,n) = sum_Pe_incidence/num_measurements;
            
        end
    end
end
result_pr
result_cross     
result_incidence
close all
for ii = 1:1:size(num_targets,1)
    for snr = 1:length(SNR_dB)
        figure
        z= plot(N,squeeze(result_pr(snr,ii,:)),'--pk',...
            N,squeeze(result_cross(snr,ii,:)),'-or',...
            N,squeeze(result_incidence(snr,ii,:)),'-.sb');
        set(z,...
       'LineWidth',2,...
         'MarkerSize',5);
        grid on
        xlabel('N');
        ylabel('Product of TA and DR');
        title(['Product of TA and DR; SNR = ',num2str(SNR_dB(snr)), ' regime ', num2str(ii) ]);
        legend('PR','Incidence','Cross');
    end
end