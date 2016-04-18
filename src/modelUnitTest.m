% this is a script designed to test the model

containerMass = 0;
containerRadius = 1;
fuelDensity = 1;
burnRate = 1;
DELTA_T = 1;
GRAVITY_CON = 6.674e-11;
% dummy input
payloadMass = 10;
trust = 100;
length = 10;
planetMass = 5.972e24;
launchAngle = pi / 4;

% calculate fuel variables
fuelVol = containerRadius^2*pi*length;
fuelMass = fuelVol * fuelDensity + containerMass;

% model rocket with fuel
index = 1;
while fuelMass(index) >= 0
    % fuel calculations
    fuelMass(index) = fuelVol(index) * fuelDensity + containerMass;
    % acceleration calculations
    mass(index) = payloadMass + fuelMass(index);
    
    forceGrav(index) = GRAVITY_CON * mass(index)*planetMass;
    forceGrav(index) = forceGrav(index)/sqrt(x(index)^2+y(index)^2);
    
    accGrav(index) = -1 * forceGrav(index)/mass(index);% considered downward
    accThrust(index) = thrust / mass(index);
    acc(index) = accThrust(index)+accGrav(index);
    
    index = index + 1;
    % (x,y) calculations
    fuelVol(index) = fuelVol(index-1)-burnRate*DELTA_T;
    y(index) = .5 * 
end
