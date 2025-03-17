clc
clear
close all
ncon=[10 20 30 40 50];
er_state_GL_EX_2=[
0.026516623821368e-03
0.007766390401283e-03
0.035950314904290e-04
0.020864904608086e-04
0.013784394672299e-04

];
er_control_GL_EX_2=[
   0.428057408345708e-03
0.122553951673490e-03
0.570638869520220e-04
0.335576430436033e-04
0.226732098011587e-04


];
er_object_GL_EX_2=[
    
0.000010116479896e-03
0.000000395707974e-03
0.000000554628744e-04
0.000000145028271e-04
0.000000046933699e-04

];
er_state_L1_EX_2=[
0.031568603834107e-03
0.010471131877154e-03
0.052759808481111e-04
0.032544396749205e-04
0.022444485444461e-04
 


];
er_control_L1_EX_2=[
   
0.514400366979469e-03
0.164735303914589e-03
0.824911558820100e-04
0.507316317750574e-04
0.349845221679645e-04


];
er_object_L1_EX_2=[
   0.000014608225498e-03
0.000000716012033e-03
0.000001174634583e-04
0.000000330593764e-04
0.000000110908581e-04


];






figure(1), clf, 
subplot(1,3,1);
semilogy(ncon,er_state_GL_EX_2,'-*','color','b')
hold on
semilogy(ncon,er_state_L1_EX_2,'-^','color','r')

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


legend('GL method','L1 method','Location','northeast')

subplot(1,3,2);

semilogy(ncon,er_control_GL_EX_2,'-*','color','b')
hold on
semilogy(ncon,er_control_L1_EX_2,'-^','color','r')

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
legend('GL method','L1 method','Location','northeast')
subplot(1,3,3);

semilogy(ncon,er_object_GL_EX_2,'-*','color','b')
hold on
semilogy(ncon,er_object_L1_EX_2,'-^','color','r')

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

legend('GL method','L1 method','Location','northeast')



