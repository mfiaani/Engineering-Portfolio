function H=evap4(Qevap)
if(Qevap<=0.5)
    H=0.3;
elseif((Qevap>0.5)&&(Qevap<=0.75))
    H=0.35;
elseif((Qevap>0.75)&&(Qevap<=1.0))
    H=0.4;
elseif((Qevap>1.0)&&(Qevap<=1.25))
    H=0.45;
elseif((Qevap>1.25)&&(Qevap<=1.5)) 
    H=0.5;
else
    fprintf('Please run the function again... Try the following:')
end
%Purpose for this if statement is to help solve the dimensions of the
%evaporator coils. Instead of adding H+=0.05 in the while loop (adding
%unforeseen errors), can have different cases
end