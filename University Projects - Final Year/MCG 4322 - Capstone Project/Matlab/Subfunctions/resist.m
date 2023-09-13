function evapL=resist(UA, Afin, evapho, evaphi)
di=0.009525; %Inner diameter of coils
Rfin=(1/(evapho*Afin)); %Thermal resistance of Fin
Rtot=1/UA; %Thermal resistance of total resistance
a=1;
b=(1/(pi*di*Rtot*Rfin))*(((Rfin-Rtot)/evapho)+(Rfin/evaphi));
c=(1/((pi^2)*(di^2)*Rtot*Rfin*evaphi*evapho)); 
d=(sqrt((b^2)+(4*a*c))); %Delta
x1=(b-d)/(2*a); %Quadratic equation 1
x2=(b+d)/(2*a); %Quadratic equation 2
if(x1>x2) %Length of the coils
    evapL=x1;
else
    evapL=x2;
%L^2 - (L/(pi*d*Rtot*Rfin))*((Rfin/ho)-(Rtot/ho)+(Rfin/hi))-(1/(pi^2*d^2*Rtot*Rfin*hi*ho));
end