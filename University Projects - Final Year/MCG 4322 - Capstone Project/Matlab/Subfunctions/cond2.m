function hi=cond2(mrdot)
di=0.009525;
p=1159.9;
mu=0.000168;
k=0.0761;
Pr=3.3;
Ac = pi*((di/2)^2); %Cross-sectional area of the coils
Red = (mrdot*di)/(mu*Ac); %Reynolds number calculation
n=0.3;
Nud=(0.023)*(Red^(0.8))*(Pr^(n));
hsp=Nud*k/di;
pl=p; %Liquid density already found 
pv=5.26; %vapour R134a via tables
Gsf=1.63; %Constant for all R134a
hfg=217; %Enthalpy liquid-vapour constant for all R134a
mrdoubledot=mrdot/Ac; %mrdot per cross section area
g=9.81; %gravity
Fr=((mrdoubledot/pl)^2)/(g*di); %Froude number
f=2.63*(Fr^0.3); %stratificationparameter calculated using Froude
Xbar=0.5; %Mean vapour mass fraction, quality distriubition assumed linear
qs=(mrdot*hfg*Xbar)/(pi*di); %Heat flux calculated using mean vapour mass fraction
hiratio=((0.6683*((pl/pv)^0.1)*(Xbar^0.16)*((1-Xbar)^0.64)*f)+(1058*((qs/(mrdoubledot*hfg))^0.7)*((1-Xbar)^0.8)*Gsf)); %ratio between single-phase and hi
hi=hsp*hiratio; %final internal convection coefficient
end


