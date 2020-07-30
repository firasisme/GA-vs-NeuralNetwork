clear
clc
close all 

np=150
a1=normrnd(0,4,[1,np]); 
b1=normrnd(0,4,[1,np]);  
a2=normrnd(0,4,[1,np]);   
b2=normrnd(0,4,[1,np]);
a3=normrnd(0,4,[1,np]);
b3=normrnd(0,4,[1,np]);
a4=normrnd(0,4,[1,np]);
b4=normrnd(0,4,[1,np]);

pop=[a1' b1' a2' b2' a3' b3' a4' b4']

figure
histogram(a1)
figure
histogram(a2)
figure
histogram(a3)
figure
histogram(a4)
figure
histogram(b1)
figure
histogram(b2)
figure
histogram(b3)
figure
histogram(b4)
