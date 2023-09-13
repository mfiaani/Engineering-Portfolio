c=1; %chord length
s=num2str(2418);
NACA=s; %4 digits
d1=str2double(s(1)); % pulls the first digit out of the scalar
d2=str2double(s(2));% pulls the second digit out of the scalar
d34=str2double(s(3:4)); % pulls the third and fourth digit out of the scalar
m=d1/100;
p=d2/10;
t=d34/100;
x=0.4;
yt =2*5*t*c*(.2969*(sqrt(x/c))+-.1260*(x/c)+-.3516*(x/c).^2+.2843*(x/c).^3+-.1015*(x/c).^4);
yc=m*(x/p^2)*(2*p-(x/c));
disp(yc)