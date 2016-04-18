function accThrust = getAccThrust(thrustVector,launchAngle, mass)
    magThrust = mag(thrustVector) / mass;
    accThrust = magThrust * [cos(launchAngle),sin(launchAngle)];
end