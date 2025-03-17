close all
clear
clc
format long
%%%%%%%%%%%%%%%%%%%%%%%%    INPUT      %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
n = input ('please enter the number of spatial nodes,  n = ');
m=n;
T=1;
%%%%%%%%%%%%%%%%%%%%%%%    Omega(alpha)   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 w = @(alpha) gamma((7/2)-alpha);
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
    t(j1) = ((j1-1)*ht);
end
t = sparse(t);

%%%%%%%%%%%%%%%%%%%%%%%% Derivative operational matrix %%%%%%%%%%%%%%%%55555
%D1 = FRACT_DO_GL_Cap_1(w,m+1,ht);
D1 = FRACT_DO_L1_Cap(w,m+1,ht);
D1 = sparse(D1);
                             %%%%%%%%%%%%%%%%%
                             
[D,W,B,C] = matrix_coefficients(n,m,D1,hx);   %coefficients matrices resulting from discretization

%%%%%%%%%%%%%%%%% exact solution for v  %%%%%%%%%%%%%%%%%%%%%
v = state_value4(n,m,x,t);
A=[];
b=[];
%%%%%%%%%%%%%%%%% exact solution for vbar  %%%%%%%%%%%%%%%%%%%%%

vbar = state_value4(n,m,x,t);

%%%%%%%%%%%%%%%%% exact solution for u  %%%%%%%%%%%%%%%%%%%%%

u = control_value4(n,m);

%%%%%%%%%%%%%%%%% exact solution for q  %%%%%%%%%%%%%%%%%%%%%

q = source1_value4(n,m,x,t);


%%%%%%%%%%%%%   quadratic form   %%%%%%%%%%%%%%%%%%%%%%

%[Wx,Wt] = SI_quadrature_n(n,m,hx,ht);
[Wx,Wt] = TR_quadrature(n,m,hx,ht);
H = [(kron(Wx,Wt))  kron(sparse(zeros(n+1)),sparse(zeros(m+1)));kron(sparse(zeros(n+1)),sparse(zeros(m+1))) (kron(Wx,Wt))];  %Hessian
f = -[((kron(Wx,Wt)))*vbar; sparse(zeros(((m+1)*(n+1)),1))];      %gradient
%f = -([vbar',zeros(1,(n+1)*(m+1))]*H);
f0=(1/2)*(vbar'*((kron(Wx,Wt))*vbar));                    %constant 



Aeq = [(D-W) -(kron(sparse(eye(n+1)),sparse(eye(m+1))));B kron(sparse(zeros(n+1)),sparse(zeros(m+1)));C kron(sparse(zeros(n+1)),sparse(zeros(m+1))) ];

g = right_initial(n,m,x);   % RHS function of initial condition
         

beq =[q ;g ;sparse(zeros(((n+1)*(m+1)),1)) ];  %RHS of equal cons

lb=[];
ub=[];
x0=[];
options = optimoptions('quadprog','Algorithm','interior-point-convex','TolCon',1e-15,'TolFun',1e-15 )
[y,fval,exitflag] = quadprog(H,f,A,b,Aeq,beq,lb,ub,x0,options)
%fval==(1/2)*(y'*H*y)+(f'*y) 
fval;
J_numerical = fval+f0;
Z =sparse([v;u]);
J_e=(1/2)*(Z'*H*Z)+(f'*Z)+f0;
J_exact = J_e(1,1);
eJ=J_exact-J_numerical;
 ev = v-y(1:((m+1)*(n+1)));
 eu = u-y((((m+1)*(n+1))+1):(2*((m+1)*(n+1))));
  error2 = [norm(ev,2)/((n+1)), norm(eu,2)/((n+1)),norm(eJ,2)/((n+1))]'

  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
 [tt,xx] = meshgrid(t,x);
vv3 = zeros (m+1,n+1);
vv2 = v;
vv3 = reshape(vv2,m+1,n+1);
v2 = vv3';
uu2 = u;
uu3 = reshape(uu2,m+1,n+1);
u2 = uu3';

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

[ttt,xxx] = meshgrid(0:0.04:1,0:0.04:1);

vvv = interp2(tt,xx,vv,ttt,xxx,'cubic');
vvve = interp2(tt,xx,v2,ttt,xxx,'cubic');
uuu = interp2(tt,xx,uu,ttt,xxx,'cubic');
uuue = interp2(tt,xx,u2,ttt,xxx,'cubic');

%%%%%%%%%%%%%%%%%%%%   draw the exact and approximate solutions    %%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(1)
%figure(1)= figure('Position',[10,10,100,100])
clf,

AX1= subplot(2,3,1);
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
AX2=subplot(2,3,2);
%set(gcf, 'renderer', 'painters');
mesh(ttt,xxx,vvve), 
%colormap([0 0 0])
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

AX3=subplot(2,3,3);
mesh(ttt,xxx,vvve-vvv),
% colormap([0 0 0])
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
xlabel t, ylabel x, zlabel v_{ex}(x,t)-v_{100}(x,t)




AX4=subplot(2,3,4);
mesh(ttt,xxx,(uuu)),
% colormap([0 0 0])
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
AX5=subplot(2,3,5);
mesh(ttt,xxx,uuue), 
%colormap([0 0 0])
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
xlabel t, ylabel x, zlabel u_{ex}(x,t)


AX6=subplot(2,3,6);
%ax = gca;
%ax.Position(2)= 1.8*ax.Position(2),
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
% 
%colormap([0 0 0])
pbaspect([6,6,6])
xlabel t, ylabel x, zlabel u_{ex}(x,t)-u_{100}(x,t)


