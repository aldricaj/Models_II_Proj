function position = calcPos(accVector, time, earthRadius)
    position = 1/2 * accVector * time^2 + [earthRadius 0];
end 