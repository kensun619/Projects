% 
% close all
% clear all
% clc
% 
% N=199;
% 
% SNR_dB = -10:5:50;
% 
% SNR = 10.^(SNR_dB./10);
% 
% threshold = max ((1./sqrt(SNR)).*0.25, 0.005);
% 
% std_dev = 1./sqrt(N*SNR);
% 
% figure
% z=semilogy(SNR_dB,threshold,'-pk',SNR_dB,std_dev,'-or');
% set(z,...
%    'LineWidth',2,...
%    'MarkerSize',5);
% xlim([-5 max(SNR_dB)]);
% %ylim([10^(-2) 1.10]);
% grid on
% xlabel('SNR (dB)');
% ylabel('Amplitude');
% %title('Probability of error');
% legend('Threshold','Std. Dev.');

SNR = 1;
N = [199, 401, 797, 997, 1499, 2503, 4001];
std_dev = 1./sqrt(N*SNR);
th = 2* sqrt(2*log10(log10(N))./(N*SNR));
figure
% z=semilogy(N,th,'-pk',N,std_dev,'-or');
z=plot(N,th,'-pk',N,std_dev,'-or');

set(z,...
   'LineWidth',2,...
   'MarkerSize',5);
%ylim([10^(-2) 1.10]);
grid on
xlabel('N');
ylabel('Amplitude');
%title('Probability of error');
legend('Threshold','Std. Dev.');
