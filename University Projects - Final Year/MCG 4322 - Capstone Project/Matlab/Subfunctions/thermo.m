function Qevap=thermo(Awindow, Afloor, Awall, Tout, Tin)
Ufloor=0.23;
Uceiling=0.19;
Uwindow=2;
Udoor=2;
Uwall=0.35;
deltaT=(Tout-Tin); 
Npeople=3; %Needs to be inputted by the user?
Adoor=1.85; %Needs to be inputted by the user?
x=((((Afloor*Ufloor)+(Afloor*Uceiling)+(Awindow*Uwindow)+(Awall*Uwall)+(Adoor*1.75*Udoor))*(deltaT))+(Npeople*100))/1000; 
if(x<=0.5)
    Qevap=0.5;
elseif((x>0.5)&&(x<=0.75))
    Qevap=0.75;
elseif((x>0.75)&&(x<=1.0))
    Qevap=1.0;
elseif((x>1.0)&&(x<=1.25))
    Qevap=1.25;
elseif((x>1.25)&&(x<=1.5)) 
    Qevap=1.5;
else
    fprintf('Please run the function again... Try the following:')
end
end