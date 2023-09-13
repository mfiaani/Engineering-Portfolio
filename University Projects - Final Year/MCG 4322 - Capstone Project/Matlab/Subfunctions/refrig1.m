function Qcond=refrig1(mrdot, h2, h3)
Qcond = mrdot*(h3-h2); %Heat transfer across condenser coils
%Qcond calculated using 1st law analysis over the condenser coils
%This value is important for finding overall heat coefficient for the
%condenser later in the code
end