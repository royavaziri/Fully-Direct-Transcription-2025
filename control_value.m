function u = control_value(n,m,x,t)
u1 = zeros(n+1,m+1);
for i = 1:n+1
    for j = 1:m+1
       
  u1(i,j) =  max([0.1 (x(i)^2)*(1-x(i)^2)*sin(1-t(j))]);
    %u1(i,j) = ((x(i)^2)*(1-x(i)^2)*sin(1-t(j)) );
 
      
    end
   
end
u1 = u1';
%u = sparse(u1(:));
u = u1(:);

end