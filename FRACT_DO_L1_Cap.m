% L1 approximation: Caputo Frational Derivative Matrix 
%dr SHAMSI%%%%%%%%%%OK

function D=FRACT_DO_L1_Cap(w,n,h)
    
    D=zeros(n,n);
    b(n)=0;
    for k=0:n-1
        b(k+1)=integral(@(alpha)w(alpha).*( (h.^(-alpha)./gamma(2-alpha).*((k+1).^(1-alpha)-k.^(1-alpha) ))),0,1);
    end

    for i=  1:n-1
        D(i+1,0+1)=-b(i );
        for j=1:i-1
            D(i+1,j+1)=b(i-j +1)-b(i-j-1 +1);
        end
        D(i+1,i+1)=b(0+1);
    end    

end