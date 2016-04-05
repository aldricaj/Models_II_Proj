% Andrew Aldrich
% basic model for rocket going into orbit

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

height = 10;           % height of tank(m)
thrust = 100;          % thrust of engine(N/s)
launchAngle = pi / 4;  % angle (rad)
payloadMass = 10;      % mass of payload (kg)

% ===================Model===========================

% Variables used
% pos = struct for coordinate system(theta,radius,x,y) (rad, m, m, m)
% time = time elapsed since start of simulation(s)
% fuelVolume = volume of fuel in tank (m^3)
% fuelMass = mass of fuel (kg)
% tankMass = mass of fuel tank(kg)
% mass = total mass of rocket(kg)
% gravForce = force due to gravity(N)
% gravAcc = accelration of rocket due to gravity(m/s^2)
% thrustAcc = accelration due to thrust(m/s^2)
% acc = net acceleration up(m/s^2)

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
gravForce = zero;
gravAcc = zero;
thrustAcc = zero;
acc = zero;

% initialize coordinates
pos.theta(1) = 0;
pos.radius(1) = planetRadius;
pos.x(1) = planetRadius;
pos.y(1) = 0;

for index = 1:length(time)
    % make sure projectile doesn't float through ground
    if pos.radius(index) < planetRadius-1
        break;
    end

    % calculate masses
    fuelMass(index) = fuelVolume(index)*fuelDensity;
    tankMass(index) = fuelMass(index) - containerMass;
    mass(index) = tankMass(index) + payloadMass;
    
    % calculate accelerations
    gravForce(index) = GRAV_CONST * planetMass * mass(index) / pos.radius(index)^2;
    gravAcc(index) = -1*gravForce(index) / mass(index);
    thrustAcc(index) = thrust * deltaT / mass(index);
    acc(index) = thrustAcc(index) * cos(launchAngle) - gravAcc(index);

    % position calculations
    %{
        a and b are place holders to the x and y components of the position
            relative to the rocket if that makes sense. Honestly, this part 
            makes my head hurt...
    %}
    a(index) = .5 * acc(index)*cos(launchAngle)*time(index)^2+pos.x(1);
    b(index) = .5 * acc(index)*sin(launchAngle)*time(index)^2+pos.y(1);
    
    pos.theta(index+1) = atan(b(index) / a(index));
    pos.radius(index+1) = sqrt(a(index)^2+b(index)^2);

    % convert from polar to cartesian
    pos.x(index+1) = pos.radius(index+1) * cos(pos.theta(index+1));
    pos.y(index+1) = pos.radius(index+1) * sin(pos.theta(index+1));

    fuelVolume(index+1) = fuelVolume(index) - burnRate * deltaT;
end
