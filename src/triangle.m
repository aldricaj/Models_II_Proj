function [ t1,t2 ] = triangle( x,y,d,s )
%triangle Summary of this function goes here
%   (x,y)=center of triangle
%   d=direction of triangle in radions
%   s=size of tiangle
%   t1=array of x-points
%   t2=array of y-points
t1(1)=x+(s*(2*(cos(d))));
t2(1)=y+(s*(2*(sin(d))));

t1(2)=x+(s*cos(d+3*pi/4));
t2(2)=y+(s*(sin(d+(3*pi/4))));

t1(3)=x+(s*(cos(d+5*pi/4)));
t2(3)=y+(s*(sin(d+(5*pi/4))));

t1(4)=t1(1);
t2(4)=t2(1);

%s1=sqrt((x1-x2)^2+(y1-y2)^2)%Tests that it is isosolies
%s2=sqrt((x1-x3)^2+(y1-y3)^2)%
%plot(t1,t2)%Plots the triangle
end
