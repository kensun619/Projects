
close all
clear all
clc

num_measurements = 1000;
SNR_dB = -10:5:30;
num_targets = 14;

Pe_pr =[0.0028    0.0547    0.2272    0.3109    0.3365    0.3471    0.3480...
    0.3453    0.3534];

TA_pr =[0.0355    0.4027    0.8970    0.9790    0.9889    0.9942    0.9936...
    0.9923    0.9931];
DR_pr =[0.0050    0.1077    0.2542    0.3164    0.3389    0.3485    0.3491...
    0.3471    0.3549];

Pe_fast =[0.0001    0.0251    0.1990    0.3892    0.5700    0.6816    0.7464...
    0.7758    0.7891];
 
TA_fast =[0.0020    0.2534    0.6130    0.7270    0.8152    0.8612    0.8824...
    0.8899    0.8929];
DR_fast =[0.0001    0.0429    0.3101    0.5249    0.6909    0.7815    0.8352...
    0.8604    0.8726];

Pe_incidence =[0    0.0217    0.3255    0.4801    0.5426    0.5707    0.5811...
    0.5871    0.5911];
TA_incidence =[0    0.0227    0.3265    0.4807    0.5434    0.5712    0.5817...
    0.5876    0.5917];
DR_incidence =[0    0.0218    0.3258    0.4808    0.5434    0.5716    0.5820...
    0.5881    0.5921];

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

title(['num measurements = ', num2str(num_measurements) ' # targets = ',num2str(num_targets)]);
legend('PR','Incidence','Cross');

 figure
z=plot(...
    SNR_dB,TA_pr,'--pk',...
    SNR_dB,TA_incidence,'-or',...
    SNR_dB,TA_fast,'-.sb');
set(z,...
   'LineWidth',2,...
   'MarkerSize',5);
xlim([min(SNR_dB) max(SNR_dB)]);

grid on
xlabel('SNR (dB)');
ylabel('TA');
title(['num measurements = ', num2str(num_measurements) ' # targets = ',num2str(num_targets)]);
legend('PR','Incidence','Cross');   
figure
z=plot(...
    SNR_dB,DR_pr,'--pk',...
    SNR_dB,DR_incidence,'-or',...
    SNR_dB,DR_fast,'-.sb');
set(z,...
   'LineWidth',2,...
   'MarkerSize',5);
xlim([min(SNR_dB) max(SNR_dB)]);

grid on
xlabel('SNR (dB)');
ylabel('DR');
title(['num measurements = ', num2str(num_measurements) ' # targets = ',num2str(num_targets)]);
legend('PR','Incidence','Cross');

num_targets =  10;
SNR_dB = -10:5:30;
num_measurements = 1000;

Pe_pr =[0.0093    0.1119    0.3323    0.4184    0.4478    0.4493    0.4645...
    0.4572    0.4509];
TA_pr =[0.0872    0.5349    0.9102    0.9817    0.9958    0.9963    0.9969...
    0.9974    0.9974];
DR_pr =[ 0.0147    0.1970    0.3698    0.4285    0.4498    0.4513    0.4664...
    0.4587    0.4523];
Pe_fast =[0.0008    0.0680    0.2934    0.5069    0.6663    0.7499    0.8122...
    0.8336    0.8447];
TA_fast =[0.0080    0.4319    0.6922    0.8005    0.8647    0.8945    0.9155...
    0.9174    0.9201];
DR_fast =[ 0.0008    0.1108    0.4105    0.6219    0.7590    0.8258    0.8750...
    0.8954    0.9046];
Pe_incidence =[0.0002    0.0796    0.4424    0.6130    0.6803    0.7141    0.7408...
    0.7476    0.7547];
TA_incidence =[0.0002    0.0806    0.4434    0.6139    0.6811    0.7148    0.7414...
    0.7485    0.7556];
DR_incidence =[0.0002    0.0798    0.4429    0.6138    0.6812    0.7151    0.7417...
     0.7486    0.7557];

% num_measurements = 10000;
% Pe_pr =
% 
%   Columns 1 through 7
% 
%     0.0090    0.1073    0.3288    0.4243    0.4518    0.4554    0.4579
% 
%   Columns 8 through 9
% 
%     0.4599    0.4609
% 
% >> 
% TA_pr =
% 
%   Columns 1 through 7
% 
%     0.0833    0.5232    0.9104    0.9860    0.9938    0.9961    0.9968
% 
%   Columns 8 through 9
% 
%     0.9963    0.9965
% 
% >> 
% DR_pr =
% 
%   Columns 1 through 7
% 
%     0.0150    0.1936    0.3661    0.4314    0.4550    0.4573    0.4597
% 
%   Columns 8 through 9
% 
%     0.4618    0.4628
% 
% >> >> >> 
% Pe_fast =
% 
%   Columns 1 through 7
% 
%     0.0012    0.0683    0.2951    0.5046    0.6609    0.7560    0.8077
% 
%   Columns 8 through 9
% 
%     0.8380    0.8524
% 
% >> 
% TA_fast =
% 
%   Columns 1 through 7
% 
%     0.0118    0.4321    0.6976    0.8002    0.8638    0.8957    0.9119
% 
%   Columns 8 through 9
% 
%     0.9204    0.9241
% 
% >> 
% DR_fast =
% 
%   Columns 1 through 7
% 
%     0.0013    0.1109    0.4101    0.6200    0.7542    0.8322    0.8732
% 
%   Columns 8 through 9
% 
%     0.8978    0.9101
% 
% >> >> >> >> 
% Pe_incidence =
% 
%   Columns 1 through 7
% 
%     0.0002    0.0801    0.4365    0.6055    0.6816    0.7194    0.7362
% 
%   Columns 8 through 9
% 
%     0.7478    0.7534
% 
% >> 
% TA_incidence =
% 
%   Columns 1 through 7
% 
%     0.0002    0.0801    0.4366    0.6056    0.6817    0.7195    0.7363
% 
%   Columns 8 through 9
% 
%     0.7479    0.7535
% 
% >> 
% DR_incidence =
% 
%   Columns 1 through 7
% 
%     0.0002    0.0801    0.4366    0.6056    0.6817    0.7195    0.7363
% 
%   Columns 8 through 9
% 
%     0.7479    0.7535
% 
% >> >> >> >> >> >> 
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

title(['num measurements = ', num2str(num_measurements) ' # targets = ',num2str(num_targets)]);
legend('PR','Incidence','Cross');

 figure
z=plot(...
    SNR_dB,TA_pr,'--pk',...
    SNR_dB,TA_incidence,'-or',...
    SNR_dB,TA_fast,'-.sb');
set(z,...
   'LineWidth',2,...
   'MarkerSize',5);
xlim([min(SNR_dB) max(SNR_dB)]);

grid on
xlabel('SNR (dB)');
ylabel('TA');
title(['num measurements = ', num2str(num_measurements) ' # targets = ',num2str(num_targets)]);
legend('PR','Incidence','Cross');   
figure
z=plot(...
    SNR_dB,DR_pr,'--pk',...
    SNR_dB,DR_incidence,'-or',...
    SNR_dB,DR_fast,'-.sb');
set(z,...
   'LineWidth',2,...
   'MarkerSize',5);
xlim([min(SNR_dB) max(SNR_dB)]);

grid on
xlabel('SNR (dB)');
ylabel('DR');
title(['num measurements = ', num2str(num_measurements) ' # targets = ',num2str(num_targets)]);
legend('PR','Incidence','Cross');








num_targets = 7;

num_measurements =  10000;

SNR_dB = -10:5:30;

Pe_pr =[0.0233    0.1798    0.4344    0.5273    0.5504    0.5563    0.5603...
     0.5587    0.5594];
TA_pr =[0.1480    0.5919    0.9095    0.9839    0.9936    0.9951    0.9959...
    0.9962    0.9954];
DR_pr =[0.0371    0.3076    0.4834    0.5369    0.5544    0.5593    0.5628...
     0.5611    0.5622];
Pe_fast =[0.0058    0.1544    0.4203    0.6204    0.7558    0.8289    0.8760...
    0.8924    0.9023];
TA_fast =[0.0408    0.5966    0.7816    0.8616    0.9087    0.9301    0.9450...
    0.9476    0.9490];
DR_fast =[0.0062    0.2229    0.5243    0.7071    0.8189    0.8786    0.9155...
    0.9297    0.9387];
Pe_incidence =[0.0018    0.1932    0.5500    0.7113    0.7924    0.8342    0.8577...
    0.8690    0.8773];
TA_incidence =[ 0.0018    0.1933    0.5501    0.7114    0.7925    0.8343    0.8578...
        0.8691    0.8774];
DR_incidence = [0.0018    0.1932    0.5501    0.7114    0.7925    0.8343    0.8578...
     0.8691    0.8774];



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

title(['num measurements = ', num2str(num_measurements) ' # targets = ',num2str(num_targets)]);
legend('PR','Incidence','Cross');

 figure
z=plot(...
    SNR_dB,TA_pr,'--pk',...
    SNR_dB,TA_incidence,'-or',...
    SNR_dB,TA_fast,'-.sb');
set(z,...
   'LineWidth',2,...
   'MarkerSize',5);
xlim([min(SNR_dB) max(SNR_dB)]);

grid on
xlabel('SNR (dB)');
ylabel('TA');
title(['num measurements = ', num2str(num_measurements) ' # targets = ',num2str(num_targets)]);
legend('PR','Incidence','Cross');   
figure
z=plot(...
    SNR_dB,DR_pr,'--pk',...
    SNR_dB,DR_incidence,'-or',...
    SNR_dB,DR_fast,'-.sb');
set(z,...
   'LineWidth',2,...
   'MarkerSize',5);
xlim([min(SNR_dB) max(SNR_dB)]);

grid on
xlabel('SNR (dB)');
ylabel('DR');
title(['num measurements = ', num2str(num_measurements) ' # targets = ',num2str(num_targets)]);
legend('PR','Incidence','Cross');










% fix signal to noise ration

SNR_dB = 0;
num_targets = 2:20;
num_measurements = 1000;

Pe_pr =[0.6877    0.6233    0.5686    0.5228    0.4603    0.4453    0.3999...
    0.3603    0.3211    0.3048    0.2702    0.2500    0.2211    0.2006...
    0.1856    0.1640    0.1540    0.1400    0.1227];
TA_pr =[0.8502    0.8805    0.8881    0.8963    0.8979    0.9163    0.9178...
    0.9153    0.9108    0.9093    0.9177    0.8962    0.8842    0.8801...
    0.8943    0.8576    0.8594    0.8316    0.8072];
DR_pr =[
    0.8060    0.7120    0.6452    0.5896    0.5172    0.4907    0.4416...
    0.3984    0.3565    0.3378    0.2989    0.2793    0.2486    0.2259...
    0.2099    0.1865    0.1757    0.1597    0.1433];

Pe_fast =[0.8212    0.7097    0.6286    0.5353    0.4752    0.4136    0.3725...
    0.3362    0.2995    0.2667    0.2447    0.2105    0.1949    0.1728...
    0.1557    0.1429    0.1315    0.1175    0.1061];

TA_fast =[    0.9617    0.9244    0.8890    0.8413    0.8165    0.7786    0.7499...
    0.7279    0.7045    0.6795    0.6597    0.6221    0.6130    0.5866...
    0.5664    0.5520    0.5416    0.5199    0.5025];
DR_fast =[ 0.8405    0.7520    0.6910    0.6214    0.5673    0.5186    0.4839...
    0.4479    0.4113    0.3810    0.3578    0.3254    0.3049    0.2805...
    0.2619    0.2454    0.2304    0.2115    0.1971];
Pe_incidence =[0.8430    0.7598    0.7046    0.6452    0.5948    0.5491    0.5141...
    0.4718    0.4283    0.4003    0.3685    0.3432    0.3256    0.2960...
    0.2721    0.2484    0.2354    0.2130    0.1976];

TA_incidence =[0.8440    0.7608    0.7056    0.6462    0.5958    0.5501    0.5151...
    0.4728    0.4291    0.4013    0.3695    0.3440    0.3266    0.2968...
    0.2726    0.2492    0.2362    0.2136    0.1984]; 
DR_incidence =[0.8440    0.7605    0.7053    0.6456    0.5955    0.5497    0.5146...
    0.4723    0.4288    0.4006    0.3690    0.3436    0.3261    0.2963...
    0.2724    0.2487    0.2357    0.2132    0.1978];
% num_measurements = 10000;
% Pe_pr =
% 
%   Columns 1 through 7
% 
%     0.6992    0.6228    0.5709    0.5190    0.4748    0.4333    0.3984
% 
%   Columns 8 through 13
% 
%     0.3631    0.3322    0.2997    0.2728    0.2477    0.2249
% 
% >> 
% TA_pr =
% 
%   Columns 1 through 7
% 
%     0.8567    0.8758    0.8920    0.8993    0.9059    0.9085    0.9161
% 
%   Columns 8 through 13
% 
%     0.9149    0.9128    0.9122    0.9070    0.9055    0.8946
% 
% >> 
% DR_pr =
% 
%   Columns 1 through 7
% 
%     0.8141    0.7113    0.6429    0.5813    0.5296    0.4826    0.4407
% 
%   Columns 8 through 13
% 
%     0.4024    0.3686    0.3329    0.3034    0.2749    0.2524
% 
% >> >> >> 
% Pe_fast =
% 
%   Columns 1 through 7
% 
%     0.8305    0.7080    0.6181    0.5419    0.4750    0.4180    0.3692
% 
%   Columns 8 through 13
% 
%     0.3326    0.2967    0.2655    0.2390    0.2140    0.1933
% 
% >> 
% TA_fast =
% 
%   Columns 1 through 7
% 
%     0.9605    0.9182    0.8821    0.8474    0.8135    0.7789    0.7487
% 
%   Columns 8 through 13
% 
%     0.7236    0.6995    0.6738    0.6524    0.6288    0.6082
% 
% >> 
% DR_fast =
% 
%   Columns 1 through 7
% 
%     0.8502    0.7539    0.6850    0.6247    0.5697    0.5229    0.4796
% 
%   Columns 8 through 13
% 
%     0.4463    0.4107    0.3807    0.3532    0.3271    0.3042
% 
% >> >> >> >> 
% Pe_incidence =
% 
%   Columns 1 through 7
% 
%     0.8481    0.7630    0.7003    0.6448    0.5968    0.5493    0.5075
% 
%   Columns 8 through 13
% 
%     0.4716    0.4357    0.4044    0.3752    0.3475    0.3219
% 
% >> 
% TA_incidence =
% 
%   Columns 1 through 7
% 
%     0.8482    0.7631    0.7004    0.6448    0.5969    0.5494    0.5076
% 
%   Columns 8 through 13
% 
%     0.4716    0.4358    0.4045    0.3753    0.3476    0.3220
% 
% >> 
% DR_incidence =
% 
%   Columns 1 through 7
% 
%     0.8482    0.7631    0.7003    0.6448    0.5969    0.5493    0.5076
% 
%   Columns 8 through 13
% 
%     0.4716    0.4358    0.4045    0.3752    0.3476    0.3220
% 
% 

figure
z=plot(...
    num_targets,Pe_pr,'--pk',...
    num_targets,Pe_incidence,'-or',...
    num_targets,Pe_fast,'-.sb');
set(z,...
   'LineWidth',2,...
   'MarkerSize',5);
grid on
xlabel('# targets');
ylabel('Product of TA and DR');
title(['num measurements = ', num2str(num_measurements) ' SNR (dB) = ',num2str(SNR_dB)]);
legend('PR','Incidence','Cross');

figure
z=plot(...
    num_targets,TA_pr,'--pk',...
    num_targets,TA_incidence,'-or',...
    num_targets,TA_fast,'-.sb');
set(z,...
   'LineWidth',2,...
   'MarkerSize',5);
grid on
xlabel('# targets');
ylabel('TA');
title(['num measurements = ', num2str(num_measurements) ' SNR (dB) = ',num2str(SNR_dB)]);
legend('PR','Incidence','Cross');


figure
z=plot(...
    num_targets,DR_pr,'--pk',...
    num_targets,DR_incidence,'-or',...
    num_targets,DR_fast,'-.sb');
set(z,...
   'LineWidth',2,...
   'MarkerSize',5);
grid on
xlabel('# targets');
ylabel('DR');
title(['num measurements = ', num2str(num_measurements) ' SNR (dB) = ',num2str(SNR_dB)]);
legend('PR','Incidence','Cross');

 
SNR_dB = 5;

num_measurements = 1000;


Pe_pr =[0.8008    0.7289    0.6693    0.6196    0.5543    0.5322    0.4938...
    0.4554    0.4146    0.4009    0.3607    0.3375    0.3110    0.2867...
    0.2699    0.2456    0.2301    0.2108    0.1911];
TA_pr =[0.9655    0.9746    0.9771    0.9782    0.9804    0.9867    0.9837...
    0.9874    0.9865    0.9841    0.9859    0.9818    0.9772    0.9769...
    0.9817    0.9661    0.9660    0.9593    0.9434];
DR_pr =[0.8285    0.7483    0.6855    0.6354    0.5657    0.5406    0.5030...
    0.4626    0.4211    0.4075    0.3672    0.3428    0.3164    0.2915...
    0.2747    0.2494    0.2343    0.2149    0.1952];
Pe_fast =[ 0.9026    0.8415    0.7812    0.7209    0.6677    0.6137    0.5812...
    0.5499    0.5110    0.4787    0.4498    0.4159    0.3906    0.3628...
    0.3414    0.3213    0.3033    0.2838    0.2628];
TA_fast =[ 0.9758    0.9602    0.9312    0.9069    0.8872    0.8627    0.8409...
    0.8241    0.8064    0.7872    0.7695    0.7445    0.7296    0.7077...
    0.6897    0.6742    0.6646    0.6442    0.6257];
DR_fast =[0.9150    0.8653    0.8250    0.7814    0.7390    0.6999    0.6789...
    0.6542    0.6229    0.5984    0.5759    0.5490    0.5261    0.5023...
     0.4848    0.4669    0.4474    0.4307    0.4102];
Pe_incidence =[0.9100    0.8664    0.8311    0.7905    0.7476    0.7019    0.6830...
    0.6355    0.6037    0.5680    0.5377    0.5122    0.4833    0.4560...
     0.4338    0.4062    0.3864    0.3658    0.3487];
TA_incidence =[ 0.9110    0.8674    0.8321    0.7915    0.7486    0.7029    0.6837...
    0.6365    0.6046    0.5689    0.5387    0.5130    0.4841    0.4568...
    0.4344    0.4070    0.3872    0.3665    0.3494];
DR_incidence =[0.9110    0.8671    0.8319    0.7909    0.7485    0.7027    0.6837...
    0.6361    0.6045    0.5686    0.5384    0.5128    0.4838    0.4566...
    0.4344    0.4067    0.3870    0.3663    0.3492];

figure
z=plot(...
    num_targets,Pe_pr,'--pk',...
    num_targets,Pe_incidence,'-or',...
    num_targets,Pe_fast,'-.sb');
set(z,...
   'LineWidth',2,...
   'MarkerSize',5);
grid on
xlabel('# targets');
ylabel('Product of TA and DR');
title(['num measurements = ', num2str(num_measurements) ' SNR (dB) = ',num2str(SNR_dB)]);
legend('PR','Incidence','Cross');

figure
z=plot(...
    num_targets,TA_pr,'--pk',...
    num_targets,TA_incidence,'-or',...
    num_targets,TA_fast,'-.sb');
set(z,...
   'LineWidth',2,...
   'MarkerSize',5);
grid on
xlabel('# targets');
ylabel('TA');
title(['num measurements = ', num2str(num_measurements) ' SNR (dB) = ',num2str(SNR_dB)]);
legend('PR','Incidence','Cross');


figure
z=plot(...
    num_targets,DR_pr,'--pk',...
    num_targets,DR_incidence,'-or',...
    num_targets,DR_fast,'-.sb');
set(z,...
   'LineWidth',2,...
   'MarkerSize',5);
grid on
xlabel('# targets');
ylabel('DR');
title(['num measurements = ', num2str(num_measurements) ' SNR (dB) = ',num2str(SNR_dB)]);
legend('PR','Incidence','Cross');



 
SNR_dB = 10;
num_targets = 2:14;
num_measurements = 10000;

Pe_pr =[ 0.8253    0.7420    0.6857    0.6343    0.5915    0.5508    0.5163...
    0.4824    0.4494    0.4189    0.3906    0.3638    0.3403];
TA_pr =[0.9814    0.9873    0.9902    0.9922    0.9934    0.9935    0.9953...
    0.9946    0.9948    0.9943    0.9929    0.9925    0.9927];
DR_pr =[0.8399    0.7511    0.6925    0.6395    0.5958    0.5549    0.5192...
    0.4854    0.4522    0.4215    0.3929    0.3661    0.3424];
Pe_fast =[0.9519    0.9097    0.8693    0.8307    0.7904    0.7558    0.7190...
     0.6907    0.6614    0.6371    0.6093    0.5908    0.5697];
TA_fast =[0.9897    0.9764    0.9608    0.9440    0.9250    0.9082    0.8917...
    0.8786    0.8636    0.8520    0.8383    0.8281    0.8170];
DR_fast =[ 0.9573    0.9243    0.8950    0.8684    0.8414    0.8189    0.7939...
    0.7744    0.7543    0.7377    0.7172    0.7042    0.6886];
Pe_incidence =[ 0.9562    0.9241    0.8944    0.8611    0.8291    0.7923    0.7541...
    0.7178    0.6797    0.6437    0.6090    0.5752    0.5423];
TA_incidence =[0.9563    0.9242    0.8945    0.8612    0.8291    0.7924    0.7542...
    0.7179    0.6798    0.6438    0.6091    0.5752    0.5424];
DR_incidence =[0.9563    0.9242    0.8945    0.8612    0.8291    0.7924    0.7542...
     0.7179    0.6798    0.6438    0.6091    0.5752    0.5424];


