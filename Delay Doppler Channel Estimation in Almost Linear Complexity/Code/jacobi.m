%JACOBI computes the Jacobi symbol, a generalization of the Legendre symb.
%
% The Jacobi symbol, (m/n), is defined whenever n is an odd number, in 
% constrast to the Legendre symbol, where n is an odd prime. The symbol has 
% the following properties:
%
%    [1] (a/n) = (b/n) if a = b mod n.
%    [2] (1/n) = 1 and (0/n) = 0.
%    [3] (2m/n) = (m/n) if n = +/- 1 mod 8. Otherwise (2m/n) = -(m/n).
%    [4] (Quadratic reciprocity) If m and n are both odd, then 
%        (m/n) = (n/m) unless both m and n are congruent to 3 mod 4, 
%        in which case (m/n) = -(n/m). 
%
%
% EXAMPLE:  j = jacobi(213,679)
%
% Petter Strandmark 2009
function j = jacobi(m,n)
    

    if mod(n,2)==0
        error('n must be odd');
    end

    m = mod(m,n); % [1]
    
    %Trivial cases  % [2]
    if m == 0
        j = 0;
    elseif m == 1
        j = 1;
        
        
    % m even number  [3]
    elseif mod(m,2) == 0  
            if abs(mod(n,8)) == 1
                j = jacobi(m/2,n);
            else
                j = -jacobi(m/2,n);
            end
    
    % both numbers are odd  [4]
    else 
        %switch places
        if mod(n,4)==3 && mod(m,4)==3
            j = -jacobi(n,m);
        else
            j = jacobi(n,m);
        end   
    end
end