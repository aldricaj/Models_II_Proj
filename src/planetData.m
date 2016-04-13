function [ M,G,R,P ] = planetData( number )
%UNTITLED Summary of this function goes here
%[MASS,GRAVITY,RADIUS,print] = MGR(number)
    name={'EARTH' 'MERCURY' 'VENUS' 'MOON' 'MARS' 'JUPITER' 'SATURN' 'URANUS' 'NEPTUNE' 'PLUTO'};
    MASS=[5.97 0.330 4.87 0.073 0.642 1898 568 86.8	102	0.0146]; %kg *10^24
    DIAMETER=[12756 4879 12104 3475 6792 142984	120536	51118	49528	2370]; %km
    GRAVITY=[9.81 3.59 8.87 1.62 3.77 25.95 11.08 10.67 14.07 0.42]; %m/s^2
    M=MASS(number)*10^24;
    G=GRAVITY(number);
    R=DIAMETER(number)/2;
    P=MASS(number);
end

