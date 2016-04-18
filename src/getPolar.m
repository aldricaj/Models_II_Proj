function [theta radius] = getPolar(posVector)
    radius = sqrt(sum(posVector.^2));
    i = [1 0];
    theta = dot(posVector, i) / radius;
end