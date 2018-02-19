function fc_m = weil(f,c,N)

f = f(:);

n = (0:N-1)';

fc_m = exp( (2.*pi.*1i./N).*c.*n.^2.*(N+1)/2 ).*f;

%fc_m_temp = f;
%fc_m = [fc_m_temp(1);fc_m_temp(N+1-(1:N-1))];

end