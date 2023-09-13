function ho=cond3(madot, di)
p=1.0919;
mu=0.000019445;
k=0.027845;
Pr=0.706;
W=0.27;
H=0.27;
f=60;
t=0.00375;
N=22;
Ac=(W-(f*t))*(H-(N*di));
Red=(madot*D)/(mu*Ac); %Reynolds number for external analysis
C=0.193; %Constant from Table 7.2
m=0.618; %Constant from Table 7.2
Nud=C*(Red^m)*(Pr^(1/3)); 
ho=Nud*k/D; 
end