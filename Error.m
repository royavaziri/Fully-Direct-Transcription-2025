clc
clear
close all
n=[10 20 30 40 50 60 70 80 90 100];
er_state_GL_EX3=[ 
   1.2799E-03
6.5429E-04
4.3987E-04
3.3135E-04
2.6579E-04
2.2190E-04
1.9045E-04
1.6681E-04
1.4839E-04
1.3363E-04



 ];
er_control_GL_EX3=[
   3.2233E-04
5.9466E-05
3.5838E-05
2.6690E-05
2.1400E-05
1.7887E-05
1.5372E-05
1.3479E-05
1.2003E-05
1.0818E-05


];
er_objective_GL_EX3=[

8.2577E-08
1.0558E-08
3.1995E-09
1.3664E-09
7.0487E-10
4.0999E-10
2.5914E-10
1.7408E-10
1.2253E-10
8.9478E-11

];
er_state_L1_EX3=[ 
   7.0685E-04
3.1512E-04
1.9597E-04
1.3989E-04
1.0772E-04
8.7034E-05
7.2693E-05
6.2208E-05
5.4232E-05
4.7975E-05

];
er_control_L1_EX3=[
    
1.7709E-04
2.8908E-05
1.6199E-05
1.1437E-05
8.8017E-06
7.1180E-06
5.9515E-06
5.0979E-06
4.4478E-06
3.9373E-06


];
er_objective_L1_EX3=[
   2.5873E-08
2.4873E-09
6.4201E-10
2.4557E-10
1.1656E-10
6.3437E-11
3.7943E-11
2.4319E-11
1.6431E-11
1.1574E-11

];
 
 figure(1), clf, 
 
subplot(1,3,1);

semilogy(n,er_state_GL_EX3,'-*','color','b')
hold on
semilogy(n,er_state_L1_EX3,'-^','color','r')
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
%set(gca, 'Position', get(gca, 'OuterPosition') - ...
   % get(gca, 'TightInset') * [-1 0 1 0; 0 -1 0 1; 0 0 1 0; 0 0 0 1]);
%plot(n,er_state_TR_1,'-o')
xlabel n, ylabel 'Error of state',


legend('GL method','L1 method','Location','northeast')
% title('Error of state '),
subplot(1,3,2);

semilogy(n,er_control_GL_EX3,'-*','color','b')
hold on
semilogy(n,er_control_L1_EX3,'-^','color','r')
%plot(n,er_control_TR_1,'-o')
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
%set(gca, 'Position', get(gca, 'OuterPosition') - ...
  %  get(gca, 'TightInset') * [-1 0 1 0; 0 -1 0 1; 0 0 1 0; 0 0 0 1]);
xlabel n, ylabel 'Error of control',


legend('GL method','L1 method','Location','northeast')
 %title('Error of control '),
subplot(1,3,3);

semilogy(n,er_objective_GL_EX3,'-*','color','b')
hold on
semilogy(n,er_objective_L1_EX3,'-^','color','r')
%plot(n,er_objective_TR_1,'-o')
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
%set(gca, 'Position', get(gca, 'OuterPosition') - ...
 %   get(gca, 'TightInset') * [-1 0 1 0; 0 -1 0 1; 0 0 1 0; 0 0 0 1]);
xlabel n, ylabel 'Error of objective',


legend('GL method','L1 method','Location','northeast')
 %title('Error of objective '),