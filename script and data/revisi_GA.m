clear
clc
close all 

%---------------Firas Mujahidin 1506732854-------------




data_reference=importdata('ikpikpuk Ivishak fm_reference.txt') 
%sesuaikan dengan nama formasi /Kingak/Shublik/Ivishak
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

vp_reference=304800./DT_reference




data=importdata('ikpikpuk Ivishak fm_test.txt')
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


vp=304800./DT


y=vp_reference
nv=8; %jumlah unknown parameter
x=DEPT_reference';
np=150; % ukuran populasi awal
ns=75; %jumlah individu survive
cm=0.5; %peluang mutasi


maxiter=100; %maximum generasi/iterasi
average=0; % average distribusi normal
std=4; %standar deviasi distribusi normal

%membuat populasi dari kumpulan parameter
a1_pop=normrnd(average,std,[1,np]); 
b1_pop=normrnd(average,std,[1,np]);  
a2_pop=normrnd(average,std,[1,np]);   
b2_pop=normrnd(average,std,[1,np]);
a3_pop=normrnd(average,std,[1,np]);
b3_pop=normrnd(average,std,[1,np]);
a4_pop=normrnd(average,std,[1,np]);
b4_pop=normrnd(average,std,[1,np]);


a1_popawal=a1_pop'
b1_popawal=b1_pop'
a2_popawal=a2_pop'
b2_popawal=b2_pop'
a3_popawal=a3_pop'
b3_popawal=b3_pop'
a4_popawal=a4_pop'
b4_popawal=b4_pop'




fx=zeros(2,np);
fx(2,:)=1:1:np;
prob=zeros(1,ns);

errplot=zeros(1,maxiter);

for iter=1:maxiter

%hitung fitness tiap populasi
for i=1:np 
a1=a1_pop(i);
b1=b1_pop(i);
a2=a2_pop(i);
b2=b2_pop(i);
a3=a3_pop(i);
b3=b3_pop(i);
a4=a4_pop(i);
b4=b4_pop(i);

y1=a1.*DEPT_reference.^b1+a2.*GR_reference.^b2+a3.*RHOB_reference.^b3+a4.*ILD_reference.^b4;
fx(1,i)=immse(y,y1); %fitness MSE 
end

[Y,I]=sort(fx(1,:),2,'ascend'); %memilih best candidate yg bakal survive
best=fx(:,I); 
prob=zeros(1,ns);

%clearing variable
a1_pop0=a1_pop;
b1_pop0=b1_pop;
a2_pop0=a2_pop;
b2_pop0=b2_pop;
a3_pop0=a3_pop;
b3_pop0=b3_pop;
a4_pop0=a4_pop;
b4_pop0=b4_pop;


a1_pop=a1_pop.*0;
b1_pop=b1_pop.*0;
a2_pop=a2_pop.*0;
b2_pop=b2_pop.*0;
a3_pop=a3_pop.*0;
b3_pop=b3_pop.*0;
a4_pop=a4_pop.*0;
b4_pop=b4_pop.*0;



for i=1:ns
    a1_pop(i)=a1_pop0(best(2,i));
    b1_pop(i)=b1_pop0(best(2,i));
    a2_pop(i)=a2_pop0(best(2,i));
    b2_pop(i)=b2_pop0(best(2,i));
    a3_pop(i)=a3_pop0(best(2,i));
    b3_pop(i)=b3_pop0(best(2,i));
    a4_pop(i)=a4_pop0(best(2,i));
    b4_pop(i)=b4_pop0(best(2,i));


    
    prob(i)=(ns-i+1)/(sum(1:1:ns));
end

%Crossover
for i=ns+1:2:np %pilih yang akan kawin
    m=1:ns;
    pick1=randsample(m,1, true, prob(1,:));
    pick2=randsample(m,1, true, prob(1,:));
    
    if pick1==pick2
       while 1
       pick2=randsample(m,1, true, prob(1,:));
       if pick1~=pick2
          break
       end
       end
    end
    ygkwn(i)=pick1;
    ygkwn(i+1)=pick2;
    %MATING
    beta=rand(1);
    a1_pop(i)=(1-beta)*a1_pop(pick2)+beta*a1_pop(pick1);
    beta=rand(1);
    a1_pop(i+1)=(1-beta)*a1_pop(pick1)+beta*a1_pop(pick2);
    beta=rand(1);
    b1_pop(i)=(1-beta)*b1_pop(pick2)+beta*b1_pop(pick1);
    beta=rand(1);
    b1_pop(i+1)=(1-beta)*b1_pop(pick1)+beta*b1_pop(pick2);
    beta=rand(1);
    a2_pop(i)=(1-beta)*a2_pop(pick2)+beta*a2_pop(pick1);    
    beta=rand(1);
    a2_pop(i+1)=(1-beta)*a2_pop(pick1)+beta*a2_pop(pick2);
    beta=rand(1);
    b2_pop(i)=(1-beta)*b2_pop(pick2)+beta*b2_pop(pick1);
    beta=rand(1);
    b2_pop(i+1)=(1-beta)*b2_pop(pick1)+beta*b2_pop(pick2);
    beta=rand(1);
    a3_pop(i)=(1-beta)*a3_pop(pick2)+beta*a3_pop(pick1);
    beta=rand(1);
    a3_pop(i+1)=(1-beta)*a3_pop(pick1)+beta*a3_pop(pick2);
    beta=rand(1);
    b3_pop(i)=(1-beta)*b3_pop(pick2)+beta*b3_pop(pick1);    
    beta=rand(1);
    b3_pop(i+1)=(1-beta)*b3_pop(pick1)+beta*b3_pop(pick2);
    beta=rand(1);
    a4_pop(i)=(1-beta)*a4_pop(pick2)+beta*a4_pop(pick1);
    beta=rand(1);
    a4_pop(i+1)=(1-beta)*a4_pop(pick1)+beta*a4_pop(pick2);
    beta=rand(1);
    b4_pop(i)=(1-beta)*b4_pop(pick2)+beta*b4_pop(pick1);
    beta=rand(1);
    b4_pop(i+1)=(1-beta)*b4_pop(pick1)+beta*b4_pop(pick2);

    

    
    
    %MUTATION
    chan_mut=floor(cm*maxiter);
    if randi([0 chan_mut],1,1)==chan_mut
       pickvar=randi([1 nv],1,1);
       pickpos=randi([0 1],1,1);
       var=normrnd(average,std,1);
       
       if pickvar==1
          a1_pop(i+pickpos)=var;
       else if pickvar==2
               b1_pop(i+pickpos)=var;
           else if pickvar==3
               a2_pop(i+pickpos)=var;
                else if pickvar==4
               b2_pop(i+pickpos)=var;
               else if pickvar==5
               a3_pop(i+pickpos)=var;
                   else if pickvar==6
                       b3_pop(i+pickpos)=var;
                        else if pickvar==7
                            a4_pop(i+pickpos)=var;
                               
                            else  
                                b4_pop(i+pickpos)=var;
                                 
                                  
                            end
                     
                                 
                   end
                   
                     
                       end
                    end
               end
          
           end
       end
        disp('mutate!')
    end
      
end




errplot(iter)=fx(1,1);

if mod(iter,1)==0 || iter==1
figure(gcf)
subplot(1,2,1)
plot(y,x,'black')
hold on
plot(y1,x,'green')
hold off
ylabel('y')
xlabel('x')
title(sprintf('Generasi ke - %i ; Error = %.2f %%)', iter,fx(1,1)));
legend('Data Input','Data Hasil Inversi','Location','NorthWest')

end

end

figure
plotregression(y,y1)


hasil=[a1 b1 a2 b2 a3 b3 a4 b4]' %
var 
pickvar



y1_test=a1.*DEPT.^b1+a2.*GR.^b2+a3.*RHOB.^b3+a4.*ILD.^b4
y_test=vp
x_test=DEPT

figure
subplot(1,2,1)
plot(y_test,x_test,'black')
hold on
plot(y1_test,x_test,'green')
hold off
ylabel('y')
xlabel('x')
title(sprintf('blind test'));
legend('Data Input','Data Hasil Inversi','Location','NorthWest')
figure
plot(errplot)
xlabel('Iterasi / Generasi ke -100')
ylabel('Error )')
ylim([0 10^5])
title(sprintf('Hasil Inversi', a1,b1,a2,b2,a3,b3));



error_GA=immse(y_test,y1_test)
corrcoef_GA = corrcoef(y_test,y1_test)
error_GA_reference=immse(y,y1)
corrcoef_GA_reference = corrcoef(y,y1)
hasil



