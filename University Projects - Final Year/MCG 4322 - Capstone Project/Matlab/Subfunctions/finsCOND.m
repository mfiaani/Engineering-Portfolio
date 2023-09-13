function condAfin=finsCOND(Nactual, L)
%==========================================================%
%                    Geometry of Fins                      %
%==========================================================%
col=4;
di=0.009525;
w=(col+0.5)*di; %Width of the fins
t=0.00375;
Lc=L+(t/2); %Corrected length of fins (given)
fmax=(w*4)/(t*5); %Max amount of fins placed on coils
f=60; %Rounded fmax, const. amount of fins
ka=237; %Conductivity of Aluminum

%==========================================================%
%                  Evap. Afin Calculations                 %
%==========================================================%

Af=(2*w*Lc); %Area of one fin
h=(Lc/Nactual); %height of one row of fins
m=(sqrt((2*h)/(ka*t))); %m for nf
nf=((tanh(m*Lc))/(m*Lc)); %efficiency of the fins
condAfin=(Af*nf*f); %Total surface area of the fins

end

