function evapUA=evap1(Qevap, T5, T1, madot)
Cp=1.007; 
Cmin = madot*Cp; %Cmin is the Specific heat on refrigerant, 
CminkW = Cmin*1000; %multiplied by 100 to convert from kW/K to W/K
%Since the refrigerant absorbs the heat in the evap coils
Thi = T5; %Thi the highest temp entering the total heat exchanger analysis
Tci = T1; %Tci is the lowest temp etnering the total heat exchanger analysis
Qmax = Cmin*(Thi-Tci); %Max heat transfer that can be outputted by the evap. coils
e = Qevap/Qmax; %e is the effectiveness by the evap. coils
NTU = -log(1-e); %Final step in the NTU-effectiveness method
evapUA = NTU*CminkW; %UA is the overall heat coefficient
%UA for evaporator coils is found now this will be used to find Rtot 
end
