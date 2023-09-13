% ======================================================================= %
%                                 PSF-4                                   %
% ======================================================================= %
% Group: PSF-4
% University of Ottawa 
% Mechanical Engineering
% ======================================================================= %

function[]=main()

%=========================================================================%
%                   Thermodynamics: Qevap Calculations                    %
%=========================================================================%

fprintf('Get the accurate temperature rating by enterint ur cooling size below:\n')
fprintf('Please enter the cubic dimensions of your room: \n');
w=input('Please enter the width: ');
l=input('Please enter the length: ');
h=input('Please enter the height: ');
Aw=input('Enter the width of the window: '); 
Al=input('Enter the length of the window: '); 
Afloor=w*l; %Area of floor
Awall=(2*w*h)+(2*l*h); %Area of walls
Vtot=w*l*h; %Volume of room #unimportant#
Awind=(Aw*Al); %Area of window

%=========================================================================%
%              Thermodynamics: Refrigerant Cycle Calculations             %
%=========================================================================%
%=======================================================%
%                   Initialise States                   %
%=======================================================%
% States 1 to 4 are R134a           %  
% States 5 to 8 are Air             %
% State 1 is saturated vapour       %
% State 2 is superheated gas        %
% State 3 is saturated liquid       %
% State 4 is saturated mixture      %
%===================================%
% Following Temperatures in Celsius %
%===================================%
T1=5; %Temperature at state 1 
T2=55.92; %Temperature at state 2
T3=55; %Temperature at state 3
T4=T1; %Temperature of at state 4 
%===================================%
%     Following Pressures in kPa    %
%===================================%
P1=349.85; %Pressure at state 1
P2=1528; %Pressure at state 2
P3=911.9; %Pressure at state 3
P4=349.5; %Pressure at state 4
%===================================%
% Variables needed to be calculated %
%===================================%
T5=input('What is the desired temperature in your house: ');
T7=input('What is the average outdoor temperature: ');
T6=T5-4; %Temperature at state 6 dependent on state 5
%T6 represents the desired air temp. leaving evap. coils
T8=T7+3.75; %Temperature at state 8 dependent on state 6
%Temperature difference decreased to increase the madot of condenser
Qevap=thermo(Awind, Afloor, Awall, T7, T5); %Qevap 
%===================================%
%   Following Enthalpies in kJ/kg   %
%===================================%
h1=253.35; %Enthalpy at state 1 (Given)
h2=282.15; %Enthalpy at state 2 (Calculated using compressor analysis)
h3=131.34; %Enthalpy at state 3 (Given)
h4=h3; %Enthalpy at state 4 (h4=h3 from flow through throttle)
hf4=58.61; %Liquid enthalpy at state 4 (From thermodynamic tables)
hfg=194.74; %Liquid-vapour enthalpy at state 4 (From thermodynamic tables)
x4=quality(h4, hf4, hfg); %Quality at state 4
%===================================%
%Following values found using 1st law%
%===================================%
mrdot=refrig(Qevap, h1, h4); %mass flow rate of the refrigerant
Qcond=refrig1(mrdot, h2, h3); %Heat transfer across condenser coils
win=refrig2(h1, h2); %Work done by the compressor
evap_madot=refrig3(T5, T6, Qevap); %madot evap. coils
cond_madot=refrig4(T7, T8, Qcond); %madot for cond. coils 
%=========================================================================%
%                   Evaporator Dimension Calculations                     %
%=========================================================================%                          
di = 0.009525; %Diameter of the coils
Devap=0.15; %Overall diameter of evap. coil system
%(di and D Initialised in main to act as global variable)
evapUA=evap1(Qevap, T5, T1, evap_madot); %evapUA
evaphi=evap2(mrdot, x4, di); %evaphi
evapHeight=evap4(Qevap);
Nactual_evap=evapGEO(evap_madot, evapUA, evaphi, evapHeight, di , Devap); 
%Amount of evap. coil rows needed for system (Calculated)
evapLAct=2*Nactual_evap*pi*Devap; %Actual length of the coils (Using Nactual)
evapAfin=finsEVAP(Nactual_evap, evapLAct, Devap); %Afin for evap. coils
evapWt = coilWeight(evapLAct, evapAfin, di); %Weight of evap. coils
evapPlateTH=statics(evapWt); %##Need to make comments on statics##
fprintf("Rows of evap. coils %d: \n ", Nactual_evap)


condUA=cond1(Qcond, T2, T7, cond_madot); %##
condhi=cond2(mrdot); %##
Nactual_cond=condGEO(cond_madot, condUA, condhi); %##
condLAct=4*Nactual_cond*pi*di; %##
Lcond=0.27;
condAfin=finsCOND(Nactual_cond, Lcond);%##
condWt = coilWeight(condLAct, condAfin, di);%## 
condPlateThickness=statics(condWt);%##
fprintf("Rows of cond. coils %d: \n ", Nactual_cond)
end