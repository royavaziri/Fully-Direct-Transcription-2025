function q = source_value(n,m,K,t,x,w)

q1 = zeros(n+1,m+1);
for i1 = 1:n+1
    for j1 = 1:m+1
        S = 0;
for k = 1:K+1
 %S = S+(((-1).^(k-1)).*((pi*t(j1)).^(2*(k-1))))* integral (@(alpha) ((w(alpha).*(t(j1).^(1-alpha)))./(gamma(2.*(k-1)+2-alpha))),0,1);
%S = S + integral (@(alpha)((((-1).^(k-1)).*((pi.*t(j1)).^(2.*(k-1))).*((t(j1)).^(1-alpha)).*w(alpha))./(gamma(2.*(k-1)+2-alpha))),0,1);
 S = S+ ((((1i)*pi*t(j1))^(k-1))+(((-1i)*pi*t(j1))^(k-1)))* (integral (@(alpha)((w(alpha)).*((t(j1)).^(1-alpha)))./(gamma(k-1+2-alpha)),0,1));
end
%q1(i1,j1) =((pi*sin(pi*x(i1)))*S)+((pi^2)*sin(pi*x(i1))*sin(pi*t(j1)));
q1(i1,j1) =(((pi/2)*sin(pi*x(i1)))*S)+((pi^2)*sin(pi*x(i1))*sin(pi*t(j1)));
    end  
end
q1 = q1';
q = sparse(q1(:));

end