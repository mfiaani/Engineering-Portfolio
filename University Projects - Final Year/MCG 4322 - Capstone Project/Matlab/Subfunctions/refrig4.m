function cond_madot=refrig4(T7, T8, Qcond)
Cp=1.007; %Specific heat of air
cond_madot=Qcond/(Cp*(T7-T8)); %Mass flow rate of air over condenser coils
%This value determines air speed needed to continue refrigerant cycle
%The mass flow rate of air for condenser is significantly higher then the
%evaporator. This is caused to give put less stress on the condenser coils,
%and optimizing the condenser coil geometry and design
end