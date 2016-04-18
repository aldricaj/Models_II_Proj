function [posVector] = runSim(launchAngle, thrust,payloadMass, planetRadius, gravity, length)
% outStruct = runSim(launchAngle, thrust,payloadMass, planetRadius, planetMass, height,verbose=0)
%     returns all calcuted values
% outStruct = runSim(launchAngle, thrust,payloadMass, planetRadius, planetMass, height)
%     returns a struct with only the position and time fields(named as theta, radius, x,y, time)
    BURN_RATE = 1;
    FUEL_DENSITY = 5;
    DELTA_T = .001;
    
    index = 1;
    fuel(index) = FUEL_DENSITY*length;
    thrustVector = calcThrust(thrust,launchAngle);
    posVector(index,1:2) = [planetRadius,0];
    [theta(index) radius(index)] = getPolar(posVector);
    time = 0;
    mass(index) = payloadMass + fuel(index);
    while fuel(index) > 0
        time = time+DELTA_T;
        thrustAcc = getAccThrust(thrustVector,launchAngle,mass(index));
        gravAccVector = calcGrav(-gravity,theta(index));
        accVector = calcAcc(thrustAcc,gravAccVector);
        index = index + 1;
        posVector(index,1:2) = calcPos(accVector, time, planetRadius);
        [theta(index) radius(index)] = getPolar(posVector(index,1:2));
        fuel(index) = fuel(index-1) - BURN_RATE;
        mass(index) = payloadMass + fuel(index);
    end
    figure(1)
    plot(posVector(:,1),posVector(:,2),'ks')
    title('Burn Plot')

    
end