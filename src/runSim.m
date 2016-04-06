function [outStruct] = runSim(launchAngle, thrust,payloadMass, planetRadius, planetMass, height,verbose=0)
% outStruct = runSim(launchAngle, thrust,payloadMass, planetRadius, planetMass, height,verbose=0)
%     returns all calcuted values
% outStruct = runSim(launchAngle, thrust,payloadMass, planetRadius, planetMass, height)
%     returns a struct with only the position and time fields(named as theta, radius, x,y, time)
    return struct('theta', [0,pi/2],'radius',[4,5],'x',[1 2],'y',[1,2],'time',[1 2]);
end
