
close all
clear all
clc

N=199;
num_targets = 5;


tau   = randi(N,[1,num_targets]) - 1;
omega = randi(N,[1,num_targets]) - 1;

% alpha = rand(1,num_targets); alpha = alpha./norm(alpha);
mu = [0.2;0.8];
sigma = 0.005;
p = [0.3,0.7];
obj = gmdistribution(mu,sigma,p);
amp = obj.random(num_targets);
amp = abs(amp');
angles = 2*pi*rand(1,num_targets);
alpha = amp.*exp(angles*1i);
alpha = alpha/norm(alpha);

slope_L = inf; p = 22;
slope_M = 0; q = 15;

if(isinf(slope_L))
    s_L = zeros(N,1); s_L(1) = 1;
else
    s_L = hseq_fn(slope_L,p,N);
end

if(isinf(slope_M))
    s_M = zeros(N,1); s_M(1) = 1;
else
    s_M = hseq_fn(slope_M,q,N);
end

R_L = pi_vect_fn(s_L,tau,omega,alpha);
R_M = pi_vect_fn(s_M,tau,omega,alpha);

% % Auto-correlation
% A_L = ambiguity_fn(s_L, s_L, N);
% A_M = ambiguity_fn(s_M, s_M, N);

% % Receiver-Chirp correlation 
% A_L = ambiguity_fn(R_L, s_L, N);
% A_M = ambiguity_fn(R_M, s_M, N);
% 
% A = abs(A_L)+abs(A_M);
% 
% figure; mesh((0:N-1),(0:N-1),abs(A_L)); shading interp; caxis([-0.1 0.2]) 
% figure; mesh((0:N-1),(0:N-1),abs(A_M)); shading interp; caxis([-0.1 0.2]) 
% figure; mesh((0:N-1),(0:N-1),abs(A)); shading interp; caxis([-0.1 0.2]) 

if( isinf(slope_M) )
    A_L_line = N*ifft(s_L.*conj(R_L)); %A_L_line = fft(R_L.*conj(s_L));
else
    A_L_line = ambiguity_fn_fft_line(R_L, s_L, slope_M, N);
end
I_L=find(abs(A_L_line)>0.005);
b=A_L_line(I_L);
y=I_L-1

if( isinf(slope_L) )
    A_M_line = N*ifft(s_M.*conj(R_M)); %A_M_line = fft(R_M.*conj(s_M));
else
    A_M_line = ambiguity_fn_fft_line(R_M, s_M, slope_L, N);
end
I_M=find(abs(A_M_line)>0.005);
a=A_M_line(I_M);
x=I_M-1

%assert x and y on # of targets

figure;
subplot(2,1,1); stem((0:N-1),abs(A_L_line)); title('On M Line');
subplot(2,1,2); stem((0:N-1),abs(A_M_line)); title('On L Line');

%processing starts below
%FIX: change length(tau) to # of targets

pair_candidates = zeros(2,length(tau).^2);

if( isinf(slope_M) && ~isinf(slope_L) )
   tau_candidates = x; tau_candidates = tau_candidates(:); tau_candidates = mod(tau_candidates,N);
   intercepts = y; 
   index = 0;
   for ii=1:length(tau)
       for jj=1:length(tau)
           index = index+1;
           pair_candidates(1,index) = tau_candidates(ii);
           pair_candidates(2,index) = mod( (slope_L*tau_candidates(ii)+intercepts(jj)) ,N); 
       end
   end   
   
elseif( ~isinf(slope_M) && isinf(slope_L) )
   tau_candidates = y; tau_candidates = tau_candidates(:); tau_candidates = mod(tau_candidates,N);
   intercepts = x; 
   index = 0;
   for ii=1:length(tau)
       for jj=1:length(tau)
           index = index+1;
           pair_candidates(1,index) = tau_candidates(ii);
           pair_candidates(2,index) = mod( (slope_M*tau_candidates(ii)+intercepts(jj)) ,N); 
       end
   end   
elseif( ~isinf(slope_M) && ~isinf(slope_L) )  
    intercepts_L = mod((slope_M-slope_L)*y,N);
    intercepts_M = mod((slope_L-slope_M)*x,N);
    
    index = 0;
    for ii=1:length(tau)
        for jj=1:length(tau)
            index = index+1;
            pair_candidates(1,index) = mod( (intercepts_M(ii) - intercepts_L(jj))*mulinv((slope_L-slope_M),N), N);
            pair_candidates(2,index) = mod( (slope_M*pair_candidates(1,index)+intercepts_M(ii)) ,N); 
        end
    end   
else
   Error('Should not happen!');
end

pair_candidates

for ii=1:length(tau)^2
    Amp_1 = R_L(:)'*( exp( -(2.*pi.*1i./N).*pair_candidates(1,ii).*pair_candidates(2,ii).*(N-1)./2 ) .*pi_fn(s_L(:), pair_candidates(1,ii), pair_candidates(2,ii)) );
    Amp_2 = R_M(:)'*( exp( -(2.*pi.*1i./N).*pair_candidates(1,ii).*pair_candidates(2,ii).*(N-1)./2 ) .*pi_fn(s_M(:), pair_candidates(1,ii), pair_candidates(2,ii)) );
    
    if(abs(Amp_1-Amp_2)<0.001)
        tau_omega_answer = [pair_candidates(1,ii) pair_candidates(2,ii)]
    end
end

