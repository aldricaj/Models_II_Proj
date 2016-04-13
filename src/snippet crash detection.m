%% has it crashed?

% insert this variable
isCrashed = false;

% if the distance of the rocket to the origin is less than the radius of
% the planet, it has crashed
% add this inside the loop in the beginning
% for index=1:range etc
    if sqrt(pos.x^2 + pos.y^2) < planetRadius
        isCrashed = true;
        break;
    end
    % your code
% end loop

% add this before the beginning of each loop
if ~isCrashed
    % for index=1:range etc
    %   put your code here
    % end
end