function Nactual=condGEO(madot, condUA, condhi)
%==========================================================%
%         Overall Geometry of Evaporator Coil system       %
%==========================================================%
di=0.009525; %Diameter of coils
Smin=0.0025; %Minimum spacing allowed between each row of coils
H=0.27; %overall height of evaporator coils in metres
W=0.27; %overall diameter of evaporator coils in metres
Nmax=(H+Smin)/(di+Smin); %Maximum amount of rows allowed for given height
Nactual=floor(Nmax);
col=4; %Columns of coils
%==========================================================%
%                    Geometry of Fins                      %
%==========================================================%
w=(col+0.5)*di; %Width of the fins
t=0.00375;
L=H+(di*2);
Lc=L+(t/2); %Corrected length of fins (given)
fmax=(w*4)/(t*5); %Max amount of fins placed on coils
f=60; %Rounded fmax, const. amount of fins
ka=237; %Conductivity of Aluminum
%===========================================================%
%                  Finding Coil Geometry                    %
%===========================================================%
Nnew=0; %Initialising the while loop
while((Nactual~=Nnew)||(Nactual~=(Nnew+1))) 
    Ac=W*(H-(Nactual*di));
    condho=evap3(madot, Ac, W); %External Convection coefficient
    condAfin=finsCOND(Nactual, L); %Afin for evap. coils
    if(Nactual>Nnew)
        condL=resist(condUA, condAfin, condho, condhi);
        Nnew=floor(condL/(col*pi*W));
        Nactual=Nactual-1;
    else
        break;
    end
end
end
    