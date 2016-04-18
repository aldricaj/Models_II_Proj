function thrustVector = calcThrust(thrust, launchAngle)
    thrustVector = thrust * [cos(launchAngle) sin(launchAngle)];
end