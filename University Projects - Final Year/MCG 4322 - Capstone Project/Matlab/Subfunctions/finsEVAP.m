function evapAfin=finsEVAP(Nactual, L, D)
%==========================================================%
%                    Geometry of Fins                      %
%==========================================================%
w=0.01905; %Width of the fins
t=0.00375; %Thickness of fins in metres (given)
Lc=L+(t/2); %Corrected length of fins (given)
fmax=((pi*D)/t)*(3/4); %Max amount of fins that can be placed 
f=90; % Number of fins (Constant through parameterization), would increase
ka=237; %Conductivity of Aluminum

%==========================================================%
%                  Evap. Afin Calculations                 %
%==========================================================%

Af=(2*w*Lc); %Area of one fin
h=(Lc/Nactual); %height of one row of fins
m=(sqrt((2*h)/(ka*t))); %m for nf
nf=((tanh(m*Lc))/(m*Lc)); %efficiency of the fins
evapAfin=(Af*nf*f); %Total surface area of the fins

end