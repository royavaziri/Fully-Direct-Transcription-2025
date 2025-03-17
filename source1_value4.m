function q = source1_value4(n,m,x,t)
q1 = zeros(n+1,m+1);
for i = 1:n+1
    for j = 1:m
        
          q1(i,j) =-((gamma(7/2)*((((t(j))^(3/2))*(t(j)-1))/(log(t(j))))*(x(i)^2))-(2*((t(j))^(5/2)))-(gamma(7/2)*((((t(j))^(3/2))*(t(j)-1))/(log(t(j))))*(x(i))));
           
    end
  
    q1(i,m+1) = -(gamma(7/2)*(x(i)^2))+(2*((t(m+1))^(5/2)))+(gamma(7/2)*(x(i)));
    
end
q1=sparse(q1);
q1 = q1';
q = sparse(q1(:));

end