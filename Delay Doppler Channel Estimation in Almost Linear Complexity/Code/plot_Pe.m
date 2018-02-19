
close all
clear all
clc

%-SNR------------------------------------
SNR_dB = -10:5:50;

num_targets = 2;

Pe_pr = [0.9826    0.8592    0.5609    0.3844    0.3502    0.3397    0.3396    0.3369    0.3376    0.3375    0.3392    0.3358    0.3380];
Pe_fast = [0.9976    0.6069    0.3028    0.1624    0.0924    0.0534    0.0312    0.0194    0.0124    0.0086    0.0080    0.0080    0.0074];
Pe_incidence = [0.9997    0.6096    0.3038    0.1665    0.0942    0.0534    0.0309     0.0188    0.0113    0.0086    0.0081    0.0078    0.0079];

figure
z=semilogy(...
    SNR_dB,Pe_pr,'--pk',...
    SNR_dB,Pe_incidence,'-or',...
    SNR_dB,Pe_fast,'-.sb');
set(z,...
   'LineWidth',2,...
   'MarkerSize',5);
xlim([min(SNR_dB) max(SNR_dB)]);
ylim([10^(-3) 1.10]);
grid on
xlabel('SNR (dB)');
ylabel('P_e');
title(['Probability of error; # targets = ',num2str(num_targets)]);
legend('PR','Incidence','Cross');

%---------------------------------------
num_targets = 6;

Pe_pr = [1.0000    1.0000    0.9980    0.9900    0.9842    0.9826    0.9820    0.9832    0.9830    0.9820    0.9816    0.9816    0.9825];
Pe_fast = [1.0000    1.0000    0.9966    0.8939    0.6727    0.4725    0.3487     0.2650    0.2263    0.2014    0.2025    0.2016    0.2001];
Pe_incidence = [1.0000    1.0000    0.9904    0.8911    0.7555    0.6442    0.5748     0.5299    0.5050    0.4918    0.4904    0.4883    0.4906];

figure
z=semilogy(...
    SNR_dB,Pe_pr,'--pk',...
    SNR_dB,Pe_incidence,'-or',...
    SNR_dB,Pe_fast,'-.sb');
set(z,...
   'LineWidth',2,...
   'MarkerSize',5);
xlim([min(SNR_dB) max(SNR_dB)]);
ylim([10^(-1) 1.10]);
grid on
xlabel('SNR (dB)');
ylabel('P_e');
title(['Probability of error; # targets = ',num2str(num_targets)]);
legend('PR','Incidence','Cross');


%-Targets--------------------------
num_targets = 2:20;

SNR_dB = 50;

Pe_pr = [0.3346    0.6280    0.8365    0.9409    0.9814    0.9959    0.9990 ...
    0.9999    0.9999    1.0000    1.0000    1.0000    1.0000    1.0000 ...
    1.0000    1.0000    1.0000    1.0000    1.0000];

Pe_fast = [0.0070    0.0416    0.0857    0.1432    0.2016    0.2699    0.3413 ...
    0.4118    0.4793    0.5529    0.6188    0.6755    0.7304    0.7783 ...
    0.8221    0.8585    0.8883    0.9138    0.9354];

Pe_incidence = [0.0073    0.0477    0.1426    0.2948    0.4891    0.6788    0.8329 ...
    0.9276    0.9748    0.9936    0.9986    0.9998    1.0000    1.0000 ...
    1.0000    1.0000    1.0000    1.0000    1.0000];

figure
z=semilogy(...
    num_targets,Pe_pr,'--pk',...
    num_targets,Pe_incidence,'-or',...
    num_targets,Pe_fast,'-.sb');
set(z,...
   'LineWidth',2,...
   'MarkerSize',5);
xlim([min(num_targets) max(num_targets)]);
ylim([10^(-3) 1.10]);
grid on
xlabel('# targets');
ylabel('P_e');
title(['Probability of error; SNR (dB) = ',num2str(SNR_dB)]);
legend('PR','Incidence','Cross');


% Unit circle
num_targets = 2;
SNR_dB = -10:5:50;
Pe_pr = [0.9459    0.6724    0.2759    0.0688    0.0323    0.0258    0.0236 ...
    0.0219    0.0218    0.0223    0.0237    0.0220    0.0209];
Pe_fast =[ 0.9893    0.1532    0.0878    0.0564    0.0364    0.0249    0.0194 ...
    0.0154    0.0136    0.0116    0.0108    0.0109    0.0099];
Pe_incidence = [0.9986    0.0101    0.0018    0.0008    0.0006    0.0003    0.0002...
    0.0001    0.0001    0.0000    0.0000    0.0000  0];

figure
z=semilogy(...
    SNR_dB,Pe_pr,'--pk',...
    SNR_dB,Pe_incidence,'-or',...
    SNR_dB,Pe_fast,'-.sb');
set(z,...
   'LineWidth',2,...
   'MarkerSize',5);
xlim([min(SNR_dB) max(SNR_dB)]);
ylim([10^(-3) 1.10]);
grid on
xlabel('SNR (dB)');
ylabel('P_e');
title(['Probability of error on unit circle; # targets = ',num2str(num_targets)]);
legend('PR','Incidence','Cross');


% Unit Circle Target 5
num_targets = 5;
SNR_dB = -10:5:50;
Pe_pr = [1.0000    0.9967    0.5842    0.1605    0.0800    0.0638    0.0605...
    0.0571    0.0575    0.0578    0.0578    0.0586    0.0583];
Pe_fast =[ 1.0000    0.9997    0.8341    0.6586    0.4814    0.3408    0.2444...
    0.1802    0.1479    0.1282    0.1113    0.1049    0.1002];
Pe_incidence =[    1.0000    0.9999    0.2838    0.2723    0.2656    0.2610    0.2622...
   0.2575    0.2589    0.2587    0.2584    0.2592    0.2609];
figure
z=semilogy(...
    SNR_dB,Pe_pr,'--pk',...
    SNR_dB,Pe_incidence,'-or',...
    SNR_dB,Pe_fast,'-.sb');
set(z,...
   'LineWidth',2,...
   'MarkerSize',5);
xlim([min(SNR_dB) max(SNR_dB)]);
ylim([10^(-2) 1.10]);
grid on
xlabel('SNR (dB)');
ylabel('P_e');
title(['Probability of error on unit circle; # targets = ',num2str(num_targets)]);
legend('PR','Incidence','Cross');

% Gaussian Mixture Model 
num_targets = 5;
SNR_dB = -10:5:50;
Pe_pr = [ 1.0000    0.9995    0.9387    0.8661    0.8506    0.8453    0.8449...
    0.8431    0.8445    0.8421    0.8441    0.8472    0.8464];
Pe_fast =[ 1.0000    1.0000    0.9647    0.8159    0.4025    0.1951    0.1304...
     0.1111    0.1010    0.0974    0.0979    0.0988    0.0981];
Pe_incidence =[1.0000    1.0000    0.8763    0.7669    0.4233    0.2968    0.2731...
  0.2635    0.2610    0.2619    0.2605    0.2551    0.2613];
figure
z=semilogy(...
    SNR_dB,Pe_pr,'--pk',...
    SNR_dB,Pe_incidence,'-or',...
    SNR_dB,Pe_fast,'-.sb');
set(z,...
   'LineWidth',2,...
   'MarkerSize',5);
xlim([min(SNR_dB) max(SNR_dB)]);
ylim([10^(-2) 1.10]);
grid on
xlabel('SNR (dB)');
ylabel('P_e');
title(['Probability of error on unit circle; # targets = ',num2str(num_targets)]);
legend('PR','Incidence','Cross');


%
% mu = [0.2;0.8];
% sigma = 0.005;
% p = [0.3,0.7];
% obj = gmdistribution(mu,sigma,p);
% amp = obj.random(num_targets(ii));
% amp = abs(amp');
% angles = 2*pi*rand(1,num_targets(ii));
% alpha = amp.*exp(angles*1i);
% alpha = alpha/norm(alpha);	 


num_targets = 2:20;

SNR_dB = 50;

Pe_pr = [0.3268    0.6067    0.7578    0.8443    0.9126    0.9585    0.9840 ...
    0.9949    0.9984    0.9996    1.0000    1.0000    1.0000    1.0000 ...
     1.0000    1.0000    1.0000    1.0000    1.0000];

Pe_fast = [0.0003    0.0222    0.0569    0.0935    0.1431    0.1927    0.2503 ...
    0.3094    0.3725    0.4339    0.4976    0.5568    0.6084    0.6654 ...
     0.7171    0.7576    0.7993    0.8305    0.8639];

Pe_incidence =[ 0.0003    0.0295    0.1143    0.2558    0.4467    0.6445    0.8113 ...
    0.9166    0.9706    0.9922    0.9981    0.9997    1.0000    1.0000 ...
    1.0000    1.0000    1.0000    1.0000    1.0000];

figure
z=semilogy(...
    num_targets,Pe_pr,'--pk',...
    num_targets,Pe_incidence,'-or',...
    num_targets,Pe_fast,'-.sb');
set(z,...
   'LineWidth',2,...
   'MarkerSize',5);
xlim([min(num_targets) max(num_targets)]);
ylim([10^(-3) 1.10]);
grid on
xlabel('# targets');
ylabel('P_e');
title(['Probability of error with mixture of Gaussian; SNR (dB) = ',num2str(SNR_dB)]);
legend('PR','Incidence','Cross');