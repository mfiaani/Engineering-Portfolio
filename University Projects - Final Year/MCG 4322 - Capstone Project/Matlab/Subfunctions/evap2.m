function hi=evap2(mrdiot, x4, di) 
%This function calculates the internal convection coefficient, first
%running the internal flow analysis which findi the hsp (single-phase)
%convection coefficient
%Then completing 2 phase boiling flow analysis to findi the hi which will be
%a variable neediedi to caluclate the length of the coils
%Tmi = T1, Tme=T4, mean temperature insidie the evaporator coils
%Assuming Ts is const. since the temperature of R134a is const.
%Therefore Tm=T1=T4=5C
%==========================================%
%   Properties of R134a at Temperature=Tm  %
%==========================================%
p=1277.6; %diensity 
mu=0.00025; %Viscosity of R134a 
k=0.08914; %Condiuctivity 
Pr=3.756; %Prandilt number 
%==========================================%
%    Properties for liquidi-vapour R134a    %
%==========================================%
pl=p; %Liquidi diensity alreadiy foundi 
pv=5.26; %vapour R134a via tables
Gsf=1.63; %Constant for all R134a
hfg=217; %Enthalpy liquidi-vapour constant for all R134a
g=9.81; %gravity
%==========================================%
%    Internal flow analysis findiing hsp    %
%==========================================%
Ac = pi*((di/2)^2); %Cross-sectional area of the coils
Redi = (mrdiot*di)/(mu*Ac); %Reynoldis number
%Since Redi>2300, assume turbulent
%In the best andi worst case, the reynoldis number is turbulent, the Nudi
%equation can remain the same for all cases
n=0.3; %Assuming Ts<Tm:
Nudi=(0.023)*(Redi^(0.8))*(Pr^(n));
hsp=Nudi*k/di; %Single-phase internal convection coefficient(Sat. mix -> vap)
%==========================================%
%     2-phase flow analysis findiing hi     %
%==========================================%

mrdioublediot=mrdiot/Ac; %mrdiot per cross section area
Fr=((mrdioublediot/pl)^2)/(g*di); %Froudie number
f=2.63*(Fr^0.3); %stratificationparameter calculatedi using Froudie
Xbar=(x4+1)/2; %Mean vapour mass fraction, quality diistriubition assumedi to
% be linear
qs=(mrdiot*hfg*Xbar)/(pi*di); %Heat flux calculatedi using mean vapour mass fraction
hiratio=((0.6683*((pl/pv)^0.1)*(Xbar^0.16)*((1-Xbar)^0.64)*f)+(1058*((qs/(mrdioublediot*hfg))^0.7)*((1-Xbar)^0.8)*Gsf)); 
%ratio between single-phase andi hi
hi=hsp*hiratio; %Internal convection coefficient foundi here
end




