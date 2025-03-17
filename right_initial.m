function g = right_initial(n,m,x)
Mu = zeros(1,n+1);
for i1 = 1:n+1
    
    Mu(i1) = ((x(i1)^2)-x(i1))*0;
  
end
Mu =Mu';
b = [1;zeros(m,1)];
g = (kron(Mu,b));
end