
% Andrew Aldrich
% basic model for rocket going into orbit
clear all;
% ================Define Inputs and constants===================

% science constants
GRAV_CONST = 6.67408e-11;

% define optional constants
burnRate = 1;       % the rate that rocket fuel is burned (m^3/s)
fuelDensity = 1;    % the density of fuel (kg/m^3)
containerMass = 0;  % the mass of the container (kg)
deltaT = 1;         % time elapsed between simulation ticks (s)
radius = 1;         % radius of tank (m)

% define required inputs
planetRadius = 6371*1000;   % radius of body (m)
planetMass = 5.972e24; % mass of body (kg)
gravParam = planetMass * GRAV_CONST;

height = 100;           % height of tank(m)
thrust = 500;          % thrust of engine(N/s)
launchAngle = pi / 4;  % angle (rad)
payloadMass = 10;      % mass of payload (kg)

% ===================Model===========================
% Conventions used
% - x and y refer to the global coordinate system with x = 0r
% - a and b refer to the x,y coordinate system rotated a quarter turn
%       a = pi/2r
% - theta is the global angle and phi refers to a local angle
%
% Variables used
% pos = struct for coordinate system(theta,radius,x,y) (rad, m, m, m)
% time = time elapsed since start of simulation(s)
% fuelVolume = volume of fuel in tank (m^3)
% fuelMass = mass of fuel (kg)
% tankMass = mass of fuel tank(kg)
% mass = total mass of rocket(kg)
% gravForce = force due to gravity(N)
% xAcc = acceleration in the x direction(m/s^2)
% yAcc = acceleration in the y direction(m/s^2)
% acc = net acceleration up(m/s^2)
% vel = velocity of the craft at each increment (m/s)
% log = a log of the flight of the rocket(only one or zero)(engine off or
%   on)

% calculations while rocket is still firing
%     Using projectile motion equations to model
%     Assuming that intial time=0
fuelVolume = pi * radius^2 * height;

% calculate time to empty
timeEmpty = fuelVolume / burnRate;
time = 0:deltaT:timeEmpty;
clear timeEmpty;

% predefine vectors
len = length(time(:));
zero = zeros(1,len);
fuelVolume = [fuelVolume, zeros(1,len-1)];
pos = struct('theta', zero, 'radius', zero, 'x', zero, 'y', zero);
fuelMass = zero;
tankMass = zero;
mass = zero;
xAcc = zero;
yAcc = zero;
thrustAcc = zero;
acc = zero;
vel = zero;
% initialize coordinates
pos.theta(1) = 0;
pos.radius(1) = planetRadius;
pos.x(1) = planetRadius;
pos.y(1) = 0;
pos.y(2) = 1e4;
vel(1,1:2) = [0 0];
k = [1 0]; % use k instead of j because j is reserved

for index = 1:length(time)
    % make sure projectile doesn't float through ground
    if pos.radius(index) < planetRadius-1
        log(index) = -1;
        break;
    end

    % calculate masses
    fuelMass(index) = fuelVolume(index)*fuelDensity;
    tankMass(index) = fuelMass(index) - containerMass;
    mass(index) = tankMass(index) + payloadMass;
    
    % calculate accelerations
    gravForce(index) = -GRAV_CONST * planetMass * mass(index) / pos.radius(index)^2;
    a = thrust*cos(launchAngle);
    b = thrust*sin(launchAngle);

    x = gravForce(index)*cos(pos.theta(index));
    y = gravForce(index)*sin(pos.theta(index));

    A = a + x;
    B = b + y;

    phi = atan(B/A);
    mag = sqrt(A^2+B^2);

    xAcc(index) = mag * cos(phi)/mass(index);
    yAcc(index) = mag * sin(phi)/mass(index);
    log(index) = 1;
    
    
    % convert from polar to cartesian
    pos.x(index+1) = .5 * xAcc(index) * time(index)+pos.x(1);
    pos.y(index+1) = .5 * yAcc(index) * time(index)+pos.y(1);
    
    vel(index+1,1:2) = [xAcc(index) yAcc(index)] + vel(index,1:2);
    phi(index) = acos(dot(vel(index,1:2),k) / (sqrt(sum(vel(index,1:2).^2)) * sqrt(sum(k).^2)));
    pos.theta(index+1) = atan(pos.y(index+1)/pos.x(index+1));
    pos.radius(index+1)= sqrt(pos.x(index+1)^2+pos.y(index+1)^2);

    fuelVolume(index+1) = fuelVolume(index) - burnRate * deltaT;
end

phi(index+1) = acos(dot(vel(1,1:2),k) / sqrt(sum(vel(1,1:2).^2)));

index = index+1;
log(index) = 0;
burnoutIndex = index-1;
return
while abs(phi(index-1)-phi(index-2)) > .0001
    time(index) = time(index-1)+deltaT;
    
    mass(index) = mass(index-1);
    gravForce(index) = -GRAV_CONST * planetMass * mass(index) / pos.radius(index)^2;
    x = gravForce(index) * cos(pos.theta(index))/mass(index);
    y = gravForce(index) * sin(pos.theta(index))/mass(index);
    
    pos.x(index+1) = .5*x*time(index).^2 + vel(index-1,1)*time(index) + pos.x(burnoutIndex);
    pos.y(index+1) = .5*y*time(index).^2 + vel(index-1,2)*time(index) + pos.y(burnoutIndex);
    pos.theta(index+1) = atan(pos.y(index+1) / pos.x(index+1));
    pos.radius(index+1)= sqrt(pos.x(index+1)^2 + pos.y(index+1)^2);
    
    vel(index,1) = -x*time(index) + vel(burnoutIndex-1,1);
    vel(index,2) = -y*time(index) + vel(burnoutIndex-1,2);
    phi(index) = acos(dot(vel(index,1:2),k) / sqrt(sum(vel(index,1:2).^2)));
    index = index + 1;
end
orbitIndex = index-1;
index = index -1;
return
%redacted calc
%{ 
period = 2*pi * sqrt(pos.radius(index)^3/(GRAV_CONST*planetMass));
for t = linspace(1,period,100000)
    mass(index) = mass(index-1);
    gravForce(index) = GRAV_CONST * planetMass * mass(index) / pos.radius(index)^2;
    x = gravForce(index) * cos(pos.theta(index));
    y = gravForce(index) * sin(pos.theta(index));
    
    pos.x(index+1) = -.5*x*t.^2 + vel(orbitIndex,1)*t + pos.x(orbitIndex);
    pos.y(index+1) = -.5*y*t.^1 + vel(orbitIndex,2)*t + pos.y(orbitIndex);
    
    pos.theta(index+1) = atan(pos.y(index+1)/pos.x(index+1));
    pos.radius(index+1)= sqrt(pos.x(index+1)^2+pos.y(index+1)^2);
    
    vel(index,1:2) = [x y] + vel(index-1,1:2);
    phi(index) = acos(dot(vel(index,1:2),k) / sqrt(sum(vel(index,1:2).^2)));
    index = index + 1;
end
%}

%{
pos_vec = [pos.x(index) pos.y(index) 0];
vel_vec = [vel(index,1:2) 0];
angular_momentum = cross(pos_vec, vel_vec);

ecc = cross(vel_vec,angular_momentum)./gravParam;
ecc = ecc - pos_vec ./ sqrt(sum(pos_vec.^2));
mag_ecc = sqrt(sum(ecc.^2));
%}
time2 = 0;
while pos.theta(index) <= pos.theta(orbitIndex)+2*pi
    % extend constants
    mass(index) = mass(index-1);
    
    % calculate acc due to gravity
    gravForce(index) = GRAV_CONST * planetMass*mass(index) / pos.radius(index-1)^2;
    xAcc = gravForce(index)*cos(pos.theta(index))/mass(index);
    yAcc = gravForce(index)*sin(pos.theta(index))/mass(index);
    vel(index,1:2) = [xAcc yAcc] + vel(index-1,1:2);
    pos.x(index) = -.5*xAcc*time2.^2 + vel(index-1,1)*time2 + pos.x(orbitIndex);
    pos.y(index) = -.5*yAcc*time2.^2 + vel(index-1,2)*time2 + pos.y(orbitIndex);
    %pos.theta(index) = atan(pos.y(index)/pos.x(index));
    pos.radius(index)= sqrt(pos.x(index)^2+pos.y(index)^2);
    
    
    pos.theta(index+1) = pos.theta(index)+.1;
    index = index+1;
    time2 = time2 + 60;% step up by one min
end
