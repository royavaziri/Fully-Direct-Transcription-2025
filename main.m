close all
clear
clc
format long
%%%%%%%%%%%%%%%%%%%%%%%%    INPUT      %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

n = input ('please enter the number of spatial nodes,  n = ');
m=n;
K=16;
T=1;
%%%%%%%%%%%%%%%%%%%%%%%    Omega(alpha)   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

w = @(alpha) 5.^(alpha);
%%%%%%%%%%%%%%    Discretization    %%%%%%%%%%%%%%%%%%%%%%%%%5

hx = 1/n;
ht = T/m;
x = zeros(1,n+1);
for i1 = 1:n+1
    x(i1) =((i1-1)*hx);
end
x = sparse(x);
t = zeros(1,m+1);
for j1 = 1:m+1
    t(j1) = (j1-1)*ht;
end
t = sparse(t);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Derivative operational matrix %%%%%%%%%%%%%%%%55555
%D1 = FRACT_DO_GL_Cap_1(w,m+1,ht);
D1 = FRACT_DO_L1_Cap(w,m+1,ht);
D1 = sparse(D1);
                       
[D,W,Bprime,C] = matrix_coefficients(n,m,D1,hx);   %coefficients matrices resulting from discretization

%%%%%%%%%%%%%%%%% exact solution  %%%%%%%%%%%%%%%%%%%%%

[v,vbar] = state_value(n,m,x,t);      %state and observation function


A=[];
b=[];
u = sparse(zeros(((n+1)*(m+1)),1));           %control function
q = source_value(n,m,K,t,x,w);        %analytical source  

Z =sparse([v;u]);     %unknown vector

%%%%%%%%%%%%%   quadratic form   %%%%%%%%%%%%%%%%%%%%%%

[Wx,Wt] = SI_quadrature(n,m,hx,ht);
%[Wx,Wt] = TR_quadrature(n,m,hx,ht);
H = [(kron(Wx,Wt))  kron(sparse(zeros(n+1)),sparse(zeros(m+1)));kron(sparse(zeros(n+1)),sparse(zeros(m+1))) (kron(Wx,Wt))];  %Hessian
f = -[((kron(Wx,Wt)))*vbar; sparse(zeros(((m+1)*(n+1)),1))];      %gradient
f0=sparse((1/2)*(vbar'*((kron(Wx,Wt))*vbar)));                    %constant 

% coefficients matrix of equal cons
Aeq = [(D-W) -(kron(sparse(eye(n+1)),sparse(eye(m+1))));Bprime kron(sparse(zeros(n+1)),sparse(zeros(m+1)));C kron(sparse(zeros(n+1)),sparse(zeros(m+1))) ];


beq =[q ;sparse( zeros((n+1)*(m+1),1));sparse(zeros(((n+1)*(m+1)),1)) ];


lb=[];
ub=[];
   x0=[];

options = optimoptions('quadprog','Algorithm','interior-point-convex','TolCon',1e-15,'TolFun',1e-15 )
[y,fval,exitflag] = quadprog(H,f,A,b,Aeq,beq,lb,ub,x0,options)
fval;
J_numerical = fval+f0;
%Z =sparse([v;u]);
J_e=(1/2)*(Z'*H*Z)+(f'*Z)+f0;
J_exact = J_e(1,1);
eJ=J_exact-J_numerical;
 ev = v-y(1:((m+1)*(n+1)));
 eu = u-y((((m+1)*(n+1))+1):(2*((m+1)*(n+1))));
 %error = [norm(ev,inf), norm(eu,inf),J_numerical]';
 error2 = [norm(ev,2)/((n+1)), norm(eu,2)/((n+1)),norm(eJ,2)/((n+1))]'

%%%%%%%%%%%%%%%%%% exact solution%%%%%%%%%%%%%%%%%%%%%%%%%%5
[xx,tt] = meshgrid(x,t);
v2 = sin(pi*xx).*sin(pi*tt);
u2 = zeros(n+1,m+1);
%%%%%%%%%%%%%%%%%% approximate solution%%%%%%%%%%%%%%%%%%%%%%%%%%5

v1 = y( 1:((m+1)*(n+1)));
vv = zeros (m+1,n+1);
vv = reshape(v1,m+1,n+1);
vv = vv';
u1 = y(((m+1)*(n+1))+1:2*(m+1)*(n+1));
uu = zeros (m+1,n+1);
uu = reshape(u1,m+1,n+1);
uu = uu';
%%%%%%%%%%%%%%%   interpolation   %%%%%%%%%%%%%%%%%%%%%%

[xxx,ttt] = meshgrid(0:.04:1,0:.04:1);

vvv = interp2(xx,tt,vv,xxx,ttt,'cubic');
vvve = interp2(xx,tt,v2,xxx,ttt,'cubic');
uuu = interp2(xx,tt,uu,xxx,ttt,'cubic');
uuue = interp2(xx,tt,u2,xxx,ttt,'cubic');

%%%%%%%%%%%%%%%%%%%%   draw the exact and approximate solutions    %%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(1), clf,
AX1=subplot(2,3,1);
mesh(ttt,xxx,vvv),
box on
set(gca,...
    'TickLabelInterpreter','latex',...
    'ActivePositionProperty','outerposition',...
    'LabelFontSizeMultiplier',1.1,...
    'TitleFontSizeMultiplier',1.7,...
    'FontSize',10,...
    'FontUnits','points',...
    'FontWeight','normal',...
    'FontName','times')
set(gca, 'Position', get(gca, 'OuterPosition') - ...
    get(gca, 'TightInset') * [-1 0 1 0; 0 -1 0 1; 0 0 1 0; 0 0 0 1]);
pbaspect([6,6,6])
xlabel t, ylabel x, zlabel v_{100}(x,t)
%colormap([0 0 0])
AX2=subplot(2,3,2);
mesh(ttt,xxx,vvve), 
box on
set(gca,...
    'TickLabelInterpreter','latex',...
    'ActivePositionProperty','outerposition',...
    'LabelFontSizeMultiplier',1.1,...
    'TitleFontSizeMultiplier',1.7,...
    'FontSize',10,...
    'FontUnits','points',...
    'FontWeight','normal',...
    'FontName','times')
set(gca, 'Position', get(gca, 'OuterPosition') - ...
    get(gca, 'TightInset') * [-1 0 1 0; 0 -1 0 1; 0 0 1 0; 0 0 0 1]);
pbaspect([6,6,6])
xlabel t, ylabel x, zlabel v_{ex}(x,t)

%colormap([0 0 0])

AX4=subplot(2,3,4);
mesh(ttt,xxx,(uuu)), 

box on
set(gca,...
    'TickLabelInterpreter','latex',...
    'ActivePositionProperty','outerposition',...
    'LabelFontSizeMultiplier',1.1,...
    'TitleFontSizeMultiplier',1.7,...
    'FontSize',10,...
    'FontUnits','points',...
    'FontWeight','normal',...
    'FontName','times')
set(gca, 'Position', get(gca, 'OuterPosition') - ...
    get(gca, 'TightInset') * [-1 0 1 0; 0 -1 0 1; 0 0 1 0; 0 0 0 1]);
pbaspect([6,6,6])
xlabel t, ylabel x, zlabel u_{100}(x,t)
%colormap([0 0 0])
AX5=subplot(2,3,5);
mesh(ttt,xxx,uuue), 

box on
set(gca,...
    'TickLabelInterpreter','latex',...
    'ActivePositionProperty','outerposition',...
    'LabelFontSizeMultiplier',1.1,...
    'TitleFontSizeMultiplier',1.7,...
    'FontSize',10,...
    'FontUnits','points',...
    'FontWeight','normal',...
    'FontName','times')
set(gca, 'Position', get(gca, 'OuterPosition') - ...
    get(gca, 'TightInset') * [-1 0 1 0; 0 -1 0 1; 0 0 1 0; 0 0 0 1]);
pbaspect([6,6,6])
xlabel t, ylabel x, zlabel u_{100}(x,t)

AX3=subplot(2,3,3);
mesh(ttt,xxx,vvve-vvv),  
box on
set(gca,...
    'TickLabelInterpreter','latex',...
    'ActivePositionProperty','outerposition',...
    'LabelFontSizeMultiplier',1.1,...
    'TitleFontSizeMultiplier',1.7,...
    'FontSize',10,...
    'FontUnits','points',...
    'FontWeight','normal',...
    'FontName','times')
set(gca, 'Position', get(gca, 'OuterPosition') - ...
    get(gca, 'TightInset') * [-1 0 1 0; 0 -1 0 1; 0 0 1 0; 0 0 0 1]);
pbaspect([6,6,6])
%colormap([0 0 0])
xlabel t, ylabel x, zlabel v_{ex}(x,t)-v_{100}(x,t)

AX6=subplot(2,3,6);
mesh(ttt,xxx,uuue-uuu), 
box on
set(gca,...
    'TickLabelInterpreter','latex',...
    'ActivePositionProperty','outerposition',...
    'LabelFontSizeMultiplier',1.1,...
    'TitleFontSizeMultiplier',1.7,...
    'FontSize',10,...
    'FontUnits','points',...
    'FontWeight','normal',...
    'FontName','times')
set(gca, 'Position', get(gca, 'OuterPosition') - ...
    get(gca, 'TightInset') * [-1 0 1 0; 0 -1 0 1; 0 0 1 0; 0 0 0 1]);
pbaspect([6,6,6])
xlabel t, ylabel x, zlabel u_{ex}(x,t)-u_{100}(x,t)

