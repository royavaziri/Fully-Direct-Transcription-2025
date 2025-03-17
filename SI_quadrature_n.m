function [Wx,Wt] = SI_quadrature_n(n,m,hx,ht)

wx1 = zeros(1,n+1);
for i = 0:n/2-1
    wx1(2*i+1)=wx1(2*i+1)+1;
    wx1(2*i+2)=wx1(2*i+2)+4;
    wx1(2*i+3)=wx1(2*i+3)+1;
end

wx =sparse( (hx/3)*wx1 );
%Wx = (diag(wx));
Wx = sparse(diag(wx));

wt1 = zeros(1,m+1);
for i = 0:m/2-1
    wt1(2*i+1)=wt1(2*i+1)+1;
    wt1(2*i+2)=wt1(2*i+2)+4;
    wt1(2*i+3)=wt1(2*i+3)+1;
end

wt =sparse( (ht/3)*wt1);
%Wt = (diag(wt));
Wt = sparse(diag(wt));

end