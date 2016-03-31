# Data Structure Design

## rocket

Struct data type with the parameters:
-**engine**: struct as defined below
-**position**: The position of the rocket in polar coordinates (angle(rad), radius(m))
-**velocity**: The velocity of the rocket in a polar vector (angle(rad), magnitude(m))
-**fuelTank**: struct as defined below
-**payloadMass**: mass of payload(kg)

## engine

Struct data type with parameters:
-**thrust**: thrust of engine(N/s)
-**burnRate**: rate that the engine burns fuel(m^3/s)

## Fuel Tank

Struct data type with parameters:
-**length**: length of tank(m)
-**emptyMass**: mass of the container without fuel(kg)
-**fuel**: fuel in tank(m^3)