function evap_madot=refrig3(T5, T6, Qevap)
Cp=1.007; %Specific heat for air
evap_madot = Qevap/(Cp*(T5 - T6)); %Evaporator mass flow rate of air
%This determines the minimum air flow speed required by the blower to
%suffice for the refrigerant cycle to continue
%This value also helps determine the external convection coefficient
end