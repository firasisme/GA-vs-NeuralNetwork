clear
clc
close all 

%---------------Firas Mujahidin 1506732854-------------




data_reference=importdata('ikpikpuk kingak fm.txt')
%sesuaikan nama formasi /Kingak/Shublik/Ivishak
ft_reference=data_reference(:,1)
DEPT_reference=0.3048.*ft_reference
GR_reference=data_reference(:,6)
SP_reference=data_reference(:,2)
CALI_reference=data_reference(:,7) 
ILD_reference=data_reference(:,3)
ILM_reference=data_reference(:,4)
LL8_reference=data_reference(:,5)
DT_reference=data_reference(:,11)
RHOB_reference=data_reference(:,8)
NPHI_reference=data_reference(:,10)
DRHO_reference=data_reference(:,9)

vp_reference=304800./DT_reference'

input_reference=[DEPT_reference GR_reference RHOB_reference ILD_reference]'


data=importdata('ikpikpuk kingak fm_test.txt')
%sesuaikan nama formasi /Kingak/Shublik/Ivishak
ft=data(:,1)
DEPT=0.3048.*ft
GR=data(:,6)
SP=data(:,2)
CALI=data(:,7) 
ILD=data(:,3)
ILM=data(:,4)
LL8=data(:,5)
DT=data(:,11)
RHOB=data(:,8)
NPHI=data(:,10)
DRHO=data(:,9)


vp=304800./DT'
input=[DEPT GR RHOB ILD]'

load('nn-kingak.mat') %sesuai nama formasi /Kingak/Shublik/Ivishak
vp_test_reference=nn(input_reference)
vp_test=nn(input)

error_NN=immse(vp,vp_test)
corrcoef_NN = corrcoef(vp,vp_test)
error_NN_reference= immse(vp_reference,vp_test_reference)
corrcoef_NN_reference = corrcoef(vp_reference,vp_test_reference)

%----------------------------input GA--------



GA_parameter=[     %hasil inversi dengan metode GA
5.37	4.22	2.37;
0.79	0.83	0.90;
5.53	0.20	6.65;
0.53	0.36	0.60;
4.41	1.82	5.75;
5.98	6.85	5.55;
4.7477	7.7978	2.3524;
1.8957	0.7561	1.07]


m=GA_parameter(:,1) %1=kingak 2= shublik 3=ivishak


vp_GA_reference= [m(1).*DEPT_reference.^m(2)+m(3).*GR_reference.^m(4)+m(5).*RHOB_reference.^m(6)+m(7).*ILD_reference.^m(8)]';
vp_GA_test=[m(1).*DEPT.^m(2)+m(3).*GR.^m(4)+m(5).*RHOB.^m(6)+m(7).*ILD.^m(8)]';




%-----------------------END GA---------------

 
 


error_NN=immse(vp,vp_test)
corrcoef_NN = corrcoef(vp,vp_test)
error_NN_reference= immse(vp_reference,vp_test_reference)
corrcoef_NN_reference = corrcoef(vp_reference,vp_test_reference)


error_GA=immse(vp,vp_GA_test)
corrcoef_GA = corrcoef(vp,vp_GA_test)
error_GA_reference=immse(vp_reference,vp_GA_reference)
corrcoef_GA_reference = corrcoef(vp_reference,vp_GA_reference)


figure
subplot(1,2,1)
plot(vp,DEPT,'black')
hold on
plot(vp_test, DEPT,'blue')
hold on
plot(vp_GA_test, DEPT,'green')
hold off
legend('Vp Observasi','Vp Estimasi NN','Vp Estimasi GA')
set(gca, 'YDir','reverse')

 subplot(1,2,2)
plot(vp_reference,DEPT_reference,'black')
hold on
plot(vp_test_reference, DEPT_reference,'blue')
hold on
plot(vp_GA_reference, DEPT_reference,'green')
hold off
legend('Vp Observasi','Vp Inversi NN','Vp Inversi GA')
set(gca, 'YDir','reverse')
