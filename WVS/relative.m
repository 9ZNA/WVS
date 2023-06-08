function Pk = relative(a,b)

%   Compute coefficient of association

    [m n] = size(a);
    if m==1
       a = a';
    end
    [m n] = size(b);
    if m==1
        b = b';
    end
    P1= sum( a.*b);
    P2= sum( a.^2 );
    P3= sum( b.^2 );
    Pk = P1/sqrt(P2*P3);
end


