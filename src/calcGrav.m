function gravAccVector = calcGrav(gravAcc, theta)
    gravAccVector = gravAcc * [cos(theta) sin(theta)];
end