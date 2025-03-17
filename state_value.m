function [v,vbar] = state_value(n,m,x,t)
v1 = zeros(n+1,m+1);
for i = 1:n+1
    for j = 1:m+1
     v1(i,j) = sin(pi*x(i))*sin(pi*t(j));
    end
end
v1=sparse(v1);
v1 = v1';
v = sparse(v1(:));
vbar = sparse(v1(:));
end