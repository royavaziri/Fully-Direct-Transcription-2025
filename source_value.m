function q = source_value(n,m,x,t)

q1 = zeros(n+1,m+1);
for i = 1:n+1
    for j = 1:m+1
             
    q1(i,j) = -max([(x(i)^2)*(1-x(i)^2)*sin(1-t(j)) 0.1]);
     %q1(i,j) = -((x(i)^2)*(1-x(i)^2)*sin(1-t(j)) );
    end
end
q1=sparse(q1);
q1 = q1';
q = sparse(q1(:));

end