function v = state_value4(n,m,x,t)
v1 = zeros(n+1,m+1);
for i = 1:n+1
    for j = 1:m+1
    % v1(i,j) =((x(i)^2)-x(i))*((t(j)+0.00001)^(5/2));
      v1(i,j) = -((x(i)^2)-x(i))*((t(j))^(5/2));          
    end
end
%v1=sparse(v1);
v1 = v1';
v = v1(:);
%vbar = v1(:);
%v = sparse(v1(:));
%vbar = sparse(v1(:));
end