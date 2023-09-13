%vortexpanelmethod

%The section that generates points for NACA four and five digit wings uses equations found in the following two references:
%Abbott, I.H. and Von Doenhoff, A.E.:'Theory of Wing Sections', Dover Publications Inc., 1981.
%Ladson, C.L., Brooks, C.W. Jr., Hill, A.S. and Sproles, D.W.:
%'Computer Program to Obtain Ordinates for NACA Airfoils'.  NASA TM-4741, 1996.

%This portion of the program requests the user to provide a number that specifies the airfoil.

clear;

disp(' ');
disp('Welcome to vortexpanelmethod');
disp(' ');
disp('Please enter a four- or five-digit number, which is either all zeros or the name of a NACA airfoil:');
disp(' ');
disp('(To use pre-defined points provided in text file type 0000 or 00000)');
disp(' ');
disp('Note:  Unmodified 4-digit NACA airfoils are recognized');
disp('       as well as unmodified 5-digit NACA airfoils whose');
disp('       first digit is 2 and whose third digit is 0 or 1.');
disp(' ');
foil=input('-> ','s');

%The following loop converts the NACA airfoil name from a string into separate numbers and
%then checks to make sure that the numbers actually correspond to a NACA airfoil recognized
%by the program.  If zeros are entered then the progrom asks for an input file.

ferr=1;
tot=0;
while ferr>0.5;
    ferr=0;
    dn=size(foil);
    if dn(2)>5;
        ferr=1;
    elseif dn(2)<4;
        ferr=1;
    end;
    if ferr ~= 1;
        for i=1:dn(2);
            naca(i)=double(foil(i))-48;
            tot=tot+naca(i);
            if naca(i)>9;
                ferr=1;
            elseif naca(i)<0;
                ferr=1;
            end;
        end;
        if tot ~= 0;
            if dn(2)==5;
                if naca(1)~=2;
                    ferr=1;
                elseif naca(2)>5;
                    ferr=1;
                elseif naca(3)>1;
                    ferr=1;
                elseif naca(3)==1;
                    if naca(2)<2;
                        ferr=1;
                    end;
                end;
            end;
            if dn(2)==4;
                if naca(3)==0;
                    if naca(4)==0;
                        ferr=1;
                    end;
                end;
            end;
        end;
    end;
    if ferr>0.5;
        disp(' ');
        disp('You have entered an airfoil number not recognized by this program.');
        disp('Please re-enter the 4 or 5 digit NACA airfoil number (just the numbers):');
        disp(' ');
        foil=input('-> ','s');
    end;
end;

%If a valid NACA airfoil number was entered, the following loop is run.  The loop asks for the angle of attack and
%number of panels desired by the user.  The program then uses methods described in the last two references above to generate
%points that describe the NACA airfoil.
%These methods generate a non-zero thickness at the trailing edge. However, the vortex panel method requires zero 
%thickness so that it can apply the Kutta condition.
%For this reason, the thickness equation provided in the references
%has been modified by the addition of the term -0.0021*xs(i)^8 .
%This way, the airfoil tapers smoothly to a thickness of 0 at x=1, avoiding any dicontinuity.
%Except very close to the trailing edge, this modification does not affect the shape of the airfoil significantly.
%Because 4 and 5 digit NACA airfoils are defined by adding a thickness to a mean (camber) line the x and xs locations are slightly different.
%x is the actual x-location of the point defining the airfoil's shape, while xs is the location on the chord used to create the x and y
%locations.  If the airfoil is symmetric (zero camber) then x and xs are equal.

if tot ~= 0;
    perr=0;
    disp(' ');
    disp('Please enter the angle of attack (in degrees):');
    av=input('-> ');
    a=av*pi/180;
    disp(' ');
    disp('Please enter the total number of panels you wish to use:');
    disp(' ');
    disp('Note:  The number of panels must be even.  An odd number');
    disp('       will be rounded to the next lowest even number.');
    lr=input('-> ');
    lri=uint32(lr/2);
    lr=double(lri)*2;
    le=lr+1;
    
    if dn(2)==4;
        m=naca(1)/100;
        p=naca(2)/10;
        thk=(naca(3)*10+naca(4))/100;
    elseif dn(2)==5;
        thk=(naca(4)*10+naca(5))/100;
        des=naca(1)*100+naca(2)*10+naca(3);
        pst=uint32((naca(2)*10+naca(3))/2);
        p=double(pst)/100;
        switch des;
        case(210), m=0.0580;
            k1=361.4;
        case(220), m=0.1260;
            k1=51.64;
        case(230), m=0.2025
            k1=15.957;
        case(240), m=0.2900;
            k1=6.643;
        case(250), m=0.3910;
            k1=3.230;
        case(221), m=0.1300;
            k1=51.990;
            kr=0.000764;
        case(231), m=0.2170;
            k1=15.793;
            kr=0.00677;
        case(241), m=0.3180;
            k1=6.520;
            kr=0.0303;
        case(251), m=0.4410;
            k1=3.191;
            kr=0.1355;
        end;
    end;
    cang=0;
    astp=2*pi/lr;
    for i=1:le;
        xs(i)=0.5+0.5*cos((i-1)*astp);
    end;
    if dn(2)==4;
        if p~=0;
            med=(lr/2)+1;
            x(med)=0;
            y(med)=0;
            yl=y(med);
            ycr(med)=yl;
            for i=(med+1):le;
                if xs(i)>=p;
                    ycc=(m/(1-p)^2)*((1-2*p)+2*p*xs(i)-xs(i)^2);
                else;
                    ycc=(m/(p^2))*(2*p*xs(i)-xs(i)^2);
                end;
                ycr(i)=ycc;
                yt=(thk/0.2)*(0.2969*xs(i)^0.5-0.126*xs(i)-0.3516*xs(i)^2+0.2843*xs(i)^3-0.1015*xs(i)^4-0.0021*xs(i)^8);
                dyc=ycc-yl;
                dxs=xs(i)-xs(i-1);
                tc=atan2(dyc,dxs);
                x(i)=xs(i)-yt*sin(tc);
                y(i)=ycc+yt*cos(tc);
                x(2*med-i)=xs(2*med-i)+yt*sin(tc);
                y(2*med-i)=ycc-yt*cos(tc);
                yl=ycc;
            end;
            y(1)=0;
            x(1)=1;
            y(le)=0;
            x(le)=1;
        else;
            med=(lr/2)+1;
            y(med)=0;
            x=xs;
            for i=(med+1):le;
                yt=(thk/0.2)*(0.2969*xs(i)^0.5-0.126*xs(i)-0.3516*xs(i)^2+0.2843*xs(i)^3-0.1015*xs(i)^4-0.0021*xs(i)^8);
                y(i)=yt;
                y(2*med-i)=-yt;
            end;
            y(1)=0;
            x(1)=1;
            y(le)=0;
            x(le)=1;
        end;   
    else;
        if naca(3)==0;
            med=(lr/2)+1;
            x(med)=0;
            y(med)=0;
            yl=y(med);
            ycr(med)=yl;
            for i=(med+1):le;
                if xs(i)>=m;
                    ycc=((k1*m^3)/6)*(1-xs(i));
                else;
                    ycc=(k1/6)*(xs(i)^3-3*m*xs(i)^2+m^2*(3-m)*xs(i));
                end;
                ycr(i)=ycc;
                yt=(thk/0.2)*(0.2969*xs(i)^0.5-0.126*xs(i)-0.3516*xs(i)^2+0.2843*xs(i)^3-0.1015*xs(i)^4-0.0021*xs(i)^8);
                dyc=ycc-yl;
                dxs=xs(i)-xs(i-1);
                tc=atan2(dyc,dxs);
                x(i)=xs(i)-yt*sin(tc);
                y(i)=ycc+yt*cos(tc);
                x(2*med-i)=xs(2*med-i)+yt*sin(tc);
                y(2*med-i)=ycc-yt*cos(tc);
                yl=ycc;
            end;
            y(1)=0;
            x(1)=1;
            y(le)=0;
            x(le)=1;
        else;
            med=(lr/2)+1;
            x(med)=0;
            y(med)=0;
            yl=y(med);
            ycr(med)=yl;
            for i=(med+1):le;
                if xs(i)>=m;
                    ycc=(k1/6)*(kr*(xs(i)-m)^3-kr*xs(i)*(1-m)^3-xs(i)*m^3+m^3);
                else;
                    ycc=(k1/6)*((xs(i)-m)^3-kr*xs(i)*(1-m)^3-xs(i)*m^3+m^3);
                end;
                ycr(i)=ycc;
                yt=(thk/0.2)*(0.2969*xs(i)^0.5-0.126*xs(i)-0.3516*xs(i)^2+0.2843*xs(i)^3-0.1015*xs(i)^4-0.0021*xs(i)^8);
                dyc=ycc-yl;
                dxs=xs(i)-xs(i-1);
                tc=atan2(dyc,dxs);
                x(i)=xs(i)-yt*sin(tc);
                y(i)=ycc+yt*cos(tc);
                x(2*med-i)=xs(2*med-i)+yt*sin(tc);
                y(2*med-i)=ycc-yt*cos(tc);
                yl=ycc;
            end;
            y(1)=0;
            x(1)=1;
            y(le)=0;
            x(le)=1;
        end;
    end;
    x=x';
    y=y';
end;

%The following accepts an input file from the user if zeros have been entered as the NACA airfoil number.

if tot==0;
    disp(' ');
    disp('Please enter the path to your input file and its name below:');
    fnmin=input('-> ','s');
    disp(' ');
    disp(fnmin);

    %The following opens the input file and reads the angle of attack, and the points describing the airfoil's shape.
    fid=fopen(fnmin);
    av=fscanf(fid,'%g',[1 1]);
    coord=fscanf(fid,'%g,%g',[2 inf]);
    fclose(fid);

    %The following checks the input file to make sure that the first and last points match and that the
    %total number of points is odd.

    lt=size(coord);
    perr=0;
    
    lti=uint32(lt(2)/2);
    ltchk=lt(2)-double(lti)*2;
    
    if ltchk ~= 1;
        perr=1;
        disp(' ');
        disp('You have specified an even number of points. Because the number of panels');
        disp('must be even and the first point is the same as the last point,');
        disp('the total number of points must be odd.  Please change the input file.');
    end;

    if coord(1,lt(2))~=coord(1,1);
        perr=1;
        disp(' ');
        disp('The first and last x coordinates are not the same.');
        disp('The first and last coordinates must match. Please');
        disp('check the inupt file.');
    end;
    
    if coord(2,lt(2))~=coord(2,1);
        perr=1;
        disp(' ');
        disp('The first and last y coordinates are not the same.');
        disp('The first and last coordinates must match. Please');
        disp('check the inupt file.');
    end;
    
    %a is angle of attack (in radians)
    a=av(1)*pi/180;
    %le is the total number of points.
    le=lt(2);
    %lr is equal to le - 1; lr is the number of control points.
    lr=le-1;
    %x is an array of boundary point x-locations
    x=coord(1,1:le)';
    %y is an array of boundary point y-locations
    y=coord(2,1:le)';

    %If there are no problems with the input then the program continues.
end;

%If no errors are encountered the program continues

if perr==0;
    
    %An output file is accepted from the user.
    
    disp(' ');
    disp('Please enter a name for your output file below, as "filename.csv" (so that it can be opened directly by Excel):');
    disp(' ');
    disp('Note: Any existing file of the same name, at the same');
    disp('      location, will be replaced.');
    fnmout=input('-> ','s');
    disp(' ');
    disp(fnmout);
    disp(' ');

    %This loop calculates the location of the control points (mid points between boundary points which is where velocity,
%circulation density and Cp are calculated).
    for i=1:lr;
        %xc is the array of control point x-locations.
        xc(i)=(x(i)+x(i+1))/2;
        %yc is the array of control point y-locaitons.
        yc(i)=(y(i)+y(i+1))/2;
        %s is the array of panel lengths (distance between two consecutive boundary points).
        s(i)=((x(i+1)-x(i))^2+(y(i+1)-y(i))^2)^(0.5);
        %t an the array of angles describing the angle of the panels relative to horizontal.
        t(i)=atan2((y(i+1)-y(i)),(x(i+1)-x(i)));
        %rhs is an array represening the right hand side of equation 5.47 (stating that the velocity normal to the panel should be zero).
        rhs(i)=sin(t(i)-a);
    end;

    %The following loop calculates the coefficients used to find the square matrix Anij for equation 5.47.
    %The variable names are the same as those given in the book (pg. 157-159).
    for i=1:lr;
        for j=1:lr;
            if i==j;
                cn1(i,j)=-1;
                cn2(i,j)=1;
                ct1(i,j)=pi/2;
                ct2(i,j)=pi/2;
            else;
                A=-(xc(i)-x(j))*cos(t(j))-(yc(i)-y(j))*sin(t(j));
                B=(xc(i)-x(j))^2+(yc(i)-y(j))^2;
                C=sin(t(i)-t(j));
                D=cos(t(i)-t(j));
                E=(xc(i)-x(j))*sin(t(j))-(yc(i)-y(j))*cos(t(j));
                F=log(1+(s(j)^2+2*A*s(j))/B);
                G=atan2((E*s(j)),(B+A*s(j)));
                P=(xc(i)-x(j))*sin(t(i)-2*t(j))+(yc(i)-y(j))*cos(t(i)-2*t(j));
                Q=(xc(i)-x(j))*cos(t(i)-2*t(j))-(yc(i)-y(j))*sin(t(i)-2*t(j));
                cn2(i,j)=D+0.5*Q*F/s(j)-(A*C+D*E)*G/s(j);
                cn1(i,j)=0.5*D*F+C*G-cn2(i,j);
                ct2(i,j)=C+0.5*P*F/s(j)+(A*D-C*E)*G/s(j);
                ct1(i,j)=0.5*C*F-D*G-ct2(i,j);
            end;
        end;
    end;

    %The following loop calculates the coefficients used in eq. 5.47 (Anij) and eq. 5.49 (Atij).
    for i=1:lr;
        an(i,1)=cn1(i,1);
        an(i,le)=cn2(i,lr);
        at(i,1)=ct1(i,1);
        at(i,le)=ct2(i,lr);
        for j=2:lr;
            an(i,j)=cn1(i,j)+cn2(i,(j-1));
            at(i,j)=ct1(i,j)+ct2(i,(j-1));
        end;
    end;
    %The Kutta condition is set here.
    an(le,1)=1;
    an(le,le)=1;
    rhs(le)=0;
    for j=2:lr;
        an(le,j)=0;
    end;
    %Because of the vagaries of Matlab, the transpose of rhs is being taken so that it becomes a column matrix and not a row matrix.
    rhs=rhs';
    %The vortex strengths are found here (solving the set of linear equations described by eq. 5.47).
    g=an\rhs;
    %This loop calculates the velocities parallel to the panels (absolute and dimentionless) and the pressure coefficients at the panels.
    
    cl=0;
    for i=1:lr;
        smt=0;
        for j=1:le;
            sm=at(i,j)*g(j);
            smt=smt+sm;
        end;
        %vd is the array of dimmensionless velocities parallel to the panels at the control points (see eq. 5.48, 5.49 and the paragraph above eq. 5.48).
        vd(i)=(cos(t(i)-a)+smt);
        %cp is the array of pressure coefficients at the control points.
        cp(i)=1-(vd(i))^2;
        cl=cl-cp(i)*s(i)*cos(t(i)-a);
    end;
    
    %The next bit creates the output file and clears the variables from Matlab.
    fid=fopen(fnmout,'w');
    for i=1:lr;
        fprintf(fid,'%g,%g,%g,%g,%g,%g,%g,%g,%g,%g\n',i,x(i),y(i),xc(i),yc(i),t(i),s(i),g(i),vd(i),cp(i));
    end;
    i=i+1;
    fprintf(fid,'%g,%g,%g,%g,%g,%g,%g,%g,%g,%g\n',i,x(i),y(i),0,0,0,0,g(i),0,cl);
    fclose(fid);
else;
    %This message tells the user that the program was abandoned because of an input error.
    disp(' ');
    disp('One or more errors has been detected in the input file.');
    disp('The program has been terminated.  Please check the input');
    disp('file and try again.');
end;

clear;