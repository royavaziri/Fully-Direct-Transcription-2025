function u = control_value4(n,m,x,t)
u1 = zeros(n+1,m+1);
for i = 1:n+1
    for j = 1:m+1
   %u1(i,j) = (gamma(7/2)*((((t(j)+0.00001)^(3/2))*(t(j)+0.00001-1))/(log(t(j)+0.00001)))*(x(i)^2))-(2*((t(j)+0.00001)^(5/2)));
   %u1(i,j) = (gamma(7/2)*((((t(j))^(3/2))*(t(j)-1))/(log(t(j))))*(x(i)^2))-(2*((t(j))^(5/2)));
   %u1(i,j) = sqrt(max([0 0.1-(x(i)-0.5)^2-(t(j)-0.5)^2]));
   u1(i,j) = 0;
    %u1(i,j)= max([0 sqrt(max([0 0.1-(x(i)-0.5)^2-(t(j)-0.5)^2]))]);
    %u1(i,j)= max([0 sqrt(0.1-(x(i)-0.5)^2-(t(j)-0.5)^2)]);          
    end
    %u1(i,m+1) = (gamma(7/2)*(x(i)^2))-(2*((t(m+1))^(5/2)));
    %u1(i,m+1) = 0;
end
u1 = u1';
%u = sparse(u1(:));
u = u1(:);
end