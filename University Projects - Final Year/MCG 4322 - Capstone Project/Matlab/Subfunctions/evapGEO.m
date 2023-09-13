function Nactual=evapGEO(madot, evapUA, evaphi, evapHeight, di, D)
%==========================================================%
%         Overall Geometry of Evaporator Coil system       %
%==========================================================%
Smin=0.0025; %Minimum spacing allowed between each row of coils
Nmax=(evapHeight+di)/(di+Smin); %Maximum amount of rows allowed for given height
Nactual=floor(Nmax); %Actual rows can't be decimal, round down
%Nmax will increase while H increases
%H increases when there is not enough spacing for the length of coils
%You will see H increase with Qevap
%di and D initialised in main function

%==========================================================%
%                    Geometry of Fins                      %
%==========================================================%
w=0.01905; %Width of the fins
t=0.00375; %Thickness of fins in metres (given) 
L=evapHeight; %Length of fins
Lc=L+(t/2); %Corrected length of fins (given)
fmax=((pi*D)/t)*(3/4); %Max amount of fins that can be placed 
f=90; % Number of fins (Constant through parameterization), would increase
ka=237; %Conductivity of Aluminum
% if D was increasing but D is also constant
%===========================================================%
%                  Finding Coil Geometry                    %
%===========================================================%
Nnew=0; %Initialising the while loop
while((Nactual~=Nnew)||(Nactual~=(Nnew+1))) 
    Ac=((pi*D)-(f*t))*(evapHeight-(Nactual*di)); %Cross-sectional area for air
    evapho=evap3(madot, Ac, D); %External Convection coefficient
    evapAfin=finsEVAP(Nactual, L, D); %Afin for evap. coils
    if(Nactual>Nnew)
        evapL=resist(evapUA, evapAfin, evapho, evaphi);
        Nnew=floor(evapL/(2*pi*D));
        Nactual=Nactual-1;
    else
        break;
    end
end
end