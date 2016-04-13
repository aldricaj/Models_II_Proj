function [f,g,p] = circle( x,y,r )
%x and y are the coordinates of the center of the circle
%r is the radius of the circle
%0.01 is the angle step, bigger values will draw the circle faster but
%you might notice imperfections (not very smooth)
ang=0:0.01:2*pi; 
xp=r*cos(ang);
yp=r*sin(ang);
f=xp+x;
g=yp+y;
%plot(x+xp,y+yp);
u=11;
p=[-u*r u*r -u*r u*r];
%axis([p])
%axis square
end

