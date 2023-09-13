


for aoa = -10:5:20   %For loop through angle of attacks 
    filename = sprintf('4345_aoa_%i.csv',aoa);    
    data = csvread(filename);    
    xp   = data(:,2);    
    yp   = data(:,3);
    xc   = data(1:end-1,4);    
    yc   = data(1:end-1,5);    
    t    = data(1:end-1,6);    
    L    = data(1:end-1,7);   
    g    = data(:,8);    
    cv   = data(1:end-1,9);    
    cp   = data(1:end-1,10);    
    cl   = data(end,10);       
    CLcp = sum(-cp.*L.*cos(t-aoa*pi/180)); %Calculateing lift coefficient
    CM = -trapz(xc,cp.*xc); %Calculating pitching moment coefficient
    disp(CLcp) %prints Coefficient of lift
    disp(CM)
end















figure 
hold on 
plot(alpha,CLcp,'kx','MarkerSize',10) 
plot(alpha,CLta,'kd','MarkerSize',10) 
plot(alpha,CLg,'ko','MarkerSize',10) 
title('CL-alpha curve for NACA 4418 Airfoil Using Different Methods'); 
legend('Cp','Circulation','Thin Airfoil','Re 3*10^6') 
xlabel('Alpha');
ylabel('CL');  
figure 
hold on 
plot(alpha,CM,'kx','MarkerSize',10) 
title('CM-alpha curve for NACA 4418 Airfoil Using Vortex Panel Method'); 
legend('Cp','Thin Airfoil','Re 3*10^6') 
xlabel('Alpha'); ylabel('CM');   
alpha0g = interp1(CLg,alpha,0); 
alpha0ta = alpha0*180/pi;   
fprintf('\nUsing thin airfoil theory, alpha0 is %.2f',alpha0ta); 
fprintf('\nUsing pressure distribution, alpha0 is %.2f',alpha0cp); 
fprintf('\nUsing circulation, alpha0 is %.2f\n',alpha0g);   
figure hold on color{1} = 'k-';
color{2} = 'b-';
color{3} = 'g-';
color{4} = 'r-'; 
color{5} = 'k--';
color{6} = 'b--';
color{7} = 'g--';     
for i = 1:j-1     
    plot(xc,CV(:,i),color{i});     
    leg{i} = cat(2,'aoa ',num2str(alpha(i))); 
end
legend(leg) 
title('Non-Dimensional Velocity on Surface of NACA 4418 Airfoil'); 
xlabel('x/c'); 
ylabel('Cv');   
figure 
hold on 
for i = 1:j-1    
    plot(xc,-CP(:,i),color{i});
end
legend(leg) 
title('Pressure Coefficient on Surface of NACA 4418 Airfoil'); 
xlabel('x/c'); 
ylabel('-Cp');
    