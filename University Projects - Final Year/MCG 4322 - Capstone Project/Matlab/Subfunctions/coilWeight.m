function weight = coilWeight(L, Afin, di)
t = 0.001; %Thickness of the coils
tf = 0.00375; %Thickness of the fins
rho_coil=8940; %Density of copper
rho_fin=2710; %Density of aluminum
Vol = t*pi*di*L; %Total volume of copper coils
weight1 = Vol*rho_coil; %Weight of the copper
Vfin = Afin*tf; %Total volume of the fins
weight2 = Vfin*rho_fin; %Weight of the aluminum
weight = weight1 + weight2; %Weight of the entire system
end