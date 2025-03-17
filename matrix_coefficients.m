function [D,W,B,C] = matrix_coefficients(n,m,D1,hx)
D = sparse( kron(eye(n+1),D1)) ;
A = zeros(n-1,n+1);
for i=1:n-1  
    A(i,i)=1;
    A(i,i+1)=-2;
   A(i,i+2)=1;
end
A = sparse(A);
b = sparse([2 -5 4 -1 zeros(1,n-3)]);
c = sparse([zeros(1,n-3) -1 4 -5 2]);
w1 = sparse([b;A;c]);
W =sparse((1/(hx^2))* sparse(kron(w1,eye(m+1))));
b1 = sparse(zeros(m+1));
b1(1,1)=1;
B =sparse( sparse(kron(eye(n+1),b1)));
C1 = sparse(zeros(n+1));
C1(1,1) = 1;
C1(n+1,n+1) = 1;
C = sparse(sparse( kron(C1,eye(m+1))));

end
