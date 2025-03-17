function q = source1_value4(n,m,x,t)
q1 = zeros(n+1,m+1);
for i = 1:n+1
    for j = 1:m
        
          %q1(i,j) = -(gamma(7/2)*((((t(j)+0.00001)^(3/2))*(t(j)+0.00001-1))/(log(t(j)+0.00001)))*(x(i)));
          %q1(i,j) = -(gamma(7/2)*((((t(j))^(3/2))*(t(j)-1))/(log(t(j))))*(x(i)));
          q1(i,j) =-((gamma(7/2)*((((t(j))^(3/2))*(t(j)-1))/(log(t(j))))*(x(i)^2))-(2*((t(j))^(5/2)))-(gamma(7/2)*((((t(j))^(3/2))*(t(j)-1))/(log(t(j))))*(x(i))));
              %-max([0 sqrt(max([0 0.1-(x(i)-0.5)^2-(t(j)-0.5)^2]))]);
            %q1(i,j)= - gamma(7/2)*(((t(j)^(3/2))*(t(j)-1)*((x(i)^2)-(x(i))))/log(t(j)))-(2*((t(j))^(5/2)));
           
    end
    %q1(i,m+1) = -(gamma(7/2)*(x(i)));
    q1(i,m+1) = -(gamma(7/2)*(x(i)^2))+(2*((t(m+1))^(5/2)))+(gamma(7/2)*(x(i)));
    
end
q1=sparse(q1);
q1 = q1';
q = sparse(q1(:));

end