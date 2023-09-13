function evapPlate=statics(weight)
n = 1.75;
Sy = 275*10^6;
Sigma_max = Sy/n;

a = 0.155;
b = 0.125;
A = pi*(a^2-b^2);
k = 0.5923;

evapPlate = sqrt((k*((weight*9.81)/A)*a^2)/Sigma_max); 
evapPlate = evapPlate*1000;
end
