
SNR_dB = -10:5:30;

num_targets = 2;



Pe_pr = [0.2788    0.4237    0.6966    0.8063    0.8246    0.8298    0.8298...
    0.8313    0.8309];

Pe_fast = [0.2717    0.6521    0.8303    0.9109    0.9499    0.9724    0.9844...
    0.9910    0.9947];

Pe_incidence =[0.2212    0.6950    0.8487    0.9179    0.9540    0.9746    0.9857...
    0.9918    0.9956];

figure
z=plot(...
    SNR_dB,Pe_pr,'--pk',...
    SNR_dB,Pe_incidence,'-or',...
    SNR_dB,Pe_fast,'-.sb');
set(z,...
   'LineWidth',2,...
   'MarkerSize',5);
xlim([min(SNR_dB) max(SNR_dB)]);

grid on
xlabel('SNR (dB)');
ylabel('Product of TA and DR');
title(['Product of TA and DR; # targets = ',num2str(num_targets)]);
legend('PR','Incidence','Cross');

% 50 measurements

Pe_pr = [0.3147    0.4209    0.7394    0.8033    0.8113    0.8333    0.7933...
    0.8283    0.8178];
Pe_fast =[0.2100    0.6750    0.8633    0.8850    0.9200    0.9800    1.0000...
    1.0000    1.0000];
Pe_incidence =[0.1900    0.6900    0.8500    0.9200    0.9300    0.9800    1.0000...
    1.0000    1.0000];

figure
z=plot(...
    SNR_dB,Pe_pr,'--pk',...
    SNR_dB,Pe_incidence,'-or',...
    SNR_dB,Pe_fast,'-.sb');
set(z,...
   'LineWidth',2,...
   'MarkerSize',5);
xlim([min(SNR_dB) max(SNR_dB)]);

grid on
xlabel('SNR (dB)');
ylabel('Product of TA and DR');
title(['Product of TA and DR; # targets = ',num2str(num_targets)]);
legend('PR','Incidence','Cross');



num_targets = 5;

Pe_pr =[0.0530    0.2545    0.5177    0.6127    0.6362    0.6408    0.6418...
    0.6439    0.6434];

Pe_fast =[0.0238    0.2670    0.5378    0.7201    0.8284    0.8854    0.9173...
    0.9335    0.9420];

Pe_incidence =[0.0118    0.3282    0.6446    0.7862    0.8616    0.9021    0.9241...
    0.9377    0.9440];

figure
z=plot(...
    SNR_dB,Pe_pr,'--pk',...
    SNR_dB,Pe_incidence,'-or',...
    SNR_dB,Pe_fast,'-.sb');
set(z,...
   'LineWidth',2,...
   'MarkerSize',5);
xlim([min(SNR_dB) max(SNR_dB)]);

grid on
xlabel('SNR (dB)');
ylabel('Product of TA and DR');
title(['Product of TA and DR; # targets = ',num2str(num_targets)]);
legend('PR','Incidence','Cross');


