function [Wx,Wt] = SI_quadrature(n,m,hx,ht)

if mod(n,2)==0
wx1 = zeros(1,n+1);
for i1 = 2:n
    if n==2
        wx1 = [1 4 1];
        break;
    else 
    if mod(i1,2)==0
    wx1(i1) = 4;
    else
    wx1(i1) = 2;
    end
    end
end
wx1(1) = 1;
wx1(n+1) = 1;
wx =sparse( (hx/3)*wx1);
%Wx = (diag(wx));
Wx = sparse(diag(wx));
else 
    disp ('n must be a even number')
    Wx= [];
end



if mod(m,2)==0
wt1 = zeros(1,m+1);
for j1 = 2:m
    if m==2
        wt1 = [1 4 1];
        break;
    else 
    if mod(j1,2)==0
    wt1(j1) = 4;
    else
    wt1(j1) = 2;
    end
    end
end
wt1(1) = 1;
wt1(m+1) = 1;
wt =sparse( (ht/3)*wt1);
%Wt = (diag(wt));
Wt = sparse(diag(wt));
else 
    disp ('m must be a even number')
    Wt= [];
end
end