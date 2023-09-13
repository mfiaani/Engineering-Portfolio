function ho=evap3(madot, Ac, D)
mu=1.77425E-05; %viscosity of Air at Tfilm
Pr=0.7107; %Prandlt number for Air at Tfilm
k=0.02515; %Conductivity for Air at Tfilm
Red=(madot*D)/(mu*Ac); %Reynolds number for external analysis
%In the best and worst case the Reynolds number was less than 4x10^5, so
%the flow can be assumed laminar, use equation 7.52
C=0.193; %Constant from Table 7.2
m=0.618; %Constant from Table 7.2
Nud=C*(Red^m)*(Pr^(1/3)); 
ho=Nud*k/D; %External convection coefficient
end
