% GL Distributed order approximation: Caputo Frational Derivative Matrix 
%dr shamsi %%%%%%%%%%%%%%%OK

function D=FRACT_DO_GL_Cap_1(w,n,h)
    
n=n-1;
    D=zeros(n+1,n+1);
    omega(n+1)=0;
    for k=0:n
       %omega(k+1)=integral(@(alpha) (h.^(-alpha)*(-1)^k.*(gamma(alpha+1))./(gamma(k+1).*gamma(alpha-k+1))),0,1);
        
        %temp=@(alpha) w(alpha(:)').*h.^(-alpha(:)').*(-1)^k.*prod( ((alpha(:)-(0:k-1))./(1:k) )');
        omega(k+1)=integral(@(alpha) w(alpha).*( (-1)^k.*h.^(-alpha).*temp(alpha,k)),0,1);
        
    end

    for i=  0:n
        for j=0:i
            D(i+1,j+1)=omega(i-j +1);
        end
    end    

end

function z=temp(alpha,k)
    z=ones(size(alpha));
    for kk=0:k-1
        z=z.*(alpha-kk)/(kk+1);
    end
end