function u = control_value4(n,m)
u1 = zeros(n+1,m+1);
for i = 1:n+1
    for j = 1:m+1
   u1(i,j) = 0;
            
    end
    
end
u1 = u1';

u = u1(:);
end