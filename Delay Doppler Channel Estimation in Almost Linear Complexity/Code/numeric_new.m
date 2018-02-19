
clc, clear all, close all

 load sim_50.mat
 
 % regime 1 num_targets = sqrt(N)
 % regime 2 num_targets = N^(1/3)
 % regime 3 num_tagerts = N^0.4
 
 
 % threshold = 3* sqrt(2*log10(log10(N))/(N*SNR)) for incidence and cross
 % method
 
 
 % threshold = min( [ 0.30+(1/SNR)*0.05 , 0.9 ] ) for pesudorandom ( need
 % improvement)
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
        ylim([0,1])
    end
end

% cross and incidence:  threshold = 3* sqrt(4*log10(log10(N))/(N*SNR));
% pr: threshold = 4*sqrt(4*log10(log10(N))/(N*SNR));
 load sim_100.mat
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
        ylim([0,1])
    end
 end

 % th = 3* sqrt(3*log10(log10(N))/(N*SNR));
 
 load sim_new_100.mat
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
        ylim([0,1]);
    end
 end