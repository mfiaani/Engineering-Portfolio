function weight = evapWeight(L)
t = 0.001; 
D = 0.009525;
rho_coil=8940; 
rho_fin=2710;
Afin = 2.152971255;
Vol = t*pi*D*L;
weight1 = Vol*rho_coil;

Vfin = Afin*t;
weight2 = Vfin*rho_fin;

weight = weight1 + weight2;
end