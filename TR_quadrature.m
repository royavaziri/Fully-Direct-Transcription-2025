function [Wx,Wt] = TR_quadrature(n,m,hx,ht)
wx1 = zeros(1,n+1);
for i1 = 2:n
    wx1(i1) = 2;
end
wx1(1) =  1;
wx1(n+1) = 1;
wx = sparse((hx/2)*wx1);
%Wx = (diag(wx));
Wx = sparse(diag(wx));
wt1 = zeros(1,m+1);
for j1 = 2:m
    wt1(j1) = 2;
end
wt1(1) =  1;
wt1(m+1) = 1;
wt = sparse((ht/2)*wt1);
%Wt = (diag(wt));
Wt = sparse(diag(wt));
end