
function [pair_candidates, len_x, len_y] = get_candidates(R_L, s_L, slope_L, R_M, s_M, slope_M, SNR, N)

% threshold = max ( [ (1/sqrt(SNR))*0.25 , 0.005] );
threshold = 3* sqrt(3*log10(log10(N))/(N*SNR));
A_L_line = ambiguity_fn_fft_line(R_L, s_L, slope_M, N);
I_L=find(abs(A_L_line)>threshold);
b=A_L_line(I_L);
y=I_L-1;

temp = sort(abs(b),'descend'); temp(1:min([3,length(temp)]));

A_M_line = ambiguity_fn_fft_line(R_M, s_M, slope_L, N);
I_M=find(abs(A_M_line)>threshold);
a=A_M_line(I_M);
x=I_M-1;

temp = sort(abs(a),'descend'); temp(1:min([3,length(temp)]));
% 
% figure;
% subplot(2,1,1); stem((0:N-1),abs(A_L_line)); title('On M Line');
% subplot(2,1,2); stem((0:N-1),abs(A_M_line)); title('On L Line');

len_x = length(x);
len_y = length(y);

pair_candidates = zeros(2,len_x*len_y);

intercepts_L = mod((slope_M-slope_L)*y,N);
intercepts_M = mod((slope_L-slope_M)*x,N);

index = 0;
for ii=1:len_x
    for jj=1:len_y
        index = index+1;
        pair_candidates(1,index) = mod( (intercepts_M(ii) - intercepts_L(jj))*mulinv((slope_L-slope_M),N), N);
        pair_candidates(2,index) = mod( (slope_M*pair_candidates(1,index)+intercepts_M(ii)) ,N);
    end
end

pair_candidates;
