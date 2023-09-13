function mrdot=refrig(Qevap, h1, h4)
mrdot = Qevap/(h1-h4); 
%Finding mass flow of refrigerant using 1st law analysis on evaporator coils
%This value is important to find internal convection coefficients 
%This value is also constant throughout the refrigerant cycle
end