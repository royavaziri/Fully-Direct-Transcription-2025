clc
clear
close all
n=[10 20 30 40 50 60 70 80 90 100];
er_state_GL_EX_1=[
    1.6686E-02
9.4900E-03
6.6063E-03
5.0693E-03
4.1148E-03
3.4643E-03
2.9923E-03
2.6342E-03
2.3531E-03
2.1266E-03

];
er_control_GL_EX_1=[
   
4.0848E-02
4.0286E-03
1.1890E-03
6.4082E-04
4.6314E-04
3.7543E-04
3.1991E-04
2.8010E-04
2.4963E-04
2.2534E-04

];
er_object_GL_EX_1=[
    
6.5455E-05
2.5547E-06
7.5612E-07
3.2937E-07
1.7279E-07
1.0181E-07
6.5005E-08
4.4029E-08
3.1203E-08
2.2920E-08


];
er_state_L1_EX_1=[
    1.3058E-02
6.9106E-03
4.5771E-03
3.3860E-03
2.6705E-03
2.1957E-03
1.8590E-03
1.6084E-03
1.4150E-03
1.2615E-03



];
er_control_L1_EX_1=[
   
4.0820E-02
3.9836E-03
1.0949E-03
5.2111E-04
3.4220E-04
2.6233E-04
2.1608E-04
1.8484E-04
1.6183E-04
1.4399E-04

];
er_object_L1_EX_1=[
  
6.0016E-05
1.4772E-06
3.7111E-07
1.4854E-07
7.3313E-08
4.1139E-08
2.5214E-08
1.6487E-08
1.1328E-08
8.0950E-09



];


figure(1), clf, 
subplot(1,3,1);

semilogy(n,er_state_GL_EX_1,'-*','color','b')
hold on
semilogy(n,er_state_L1_EX_1,'-^','color','r')
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
xlabel n, ylabel 'Error of state',
%xlabel n, ylabel 'error of state, W1',
legend('GL method','L1 method','Location','northeast')
subplot(1,3,2);

semilogy(n,er_control_GL_EX_1,'-*','color','b')
hold on
semilogy(n,er_control_L1_EX_1,'-^','color','r')
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

xlabel n, ylabel 'Error of control',
%xlabel n, ylabel 'error of control, W1',
legend('GL method','L1 method','Location','northeast')
subplot(1,3,3);
semilogy(n,er_object_GL_EX_1,'-*','color','b')
hold on
semilogy(n,er_object_L1_EX_1,'-^','color','r')
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

xlabel n, ylabel 'Error of objective',
%xlabel n, ylabel 'error of objective, W1',
legend('GL method','L1 method','Location','northeast')


