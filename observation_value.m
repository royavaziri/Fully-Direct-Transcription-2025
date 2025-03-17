function vbar = observation_value(n,m,t,x,w)
K = 6;
vbar1 = zeros(n+1,m+1);
for i1 = 1:n+1
    for j1 = 1:m+1
        S = 0;
        for k = 1:K+1
            %S = S+integral(@(alpha)  ((k.*((1-t(j1)).^(k-alpha)))./(gamma(k+1-alpha))).*w(alpha),0,1);
            S = S + integral (@(alpha)((((-1).^(k+1)).*(((1-t(j1))).^(((2.*k)-alpha-1))).*w(alpha))./(gamma((2.*k)-alpha))),0,1);
        end
        vbar1(i1,j1) = ((x(i1)^2*(1-x(i1)^2))*S)-((2-(12*(x(i1)^2))).*sin(1-t(j1)));
    
    end  
end
vbar1 = vbar1';
vbar = sparse(vbar1(:));
end