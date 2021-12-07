function [los] = has_los(B, x, p)
%[los] = has_los(B, x, p) Test if there is line of sight visibility to a
%point
%
%   Tests if a point p is visible from a camera located at x, given 
%   obstacles defined by B. 
%   NOTE: this function does not test whether or not p is within the
%   camera's FOV, it only tests whether it is occluded by obstacles
%
% Inputs:
%   B       Obstacles, boxes with faces aligned to the XY, XZ, and YZ
%           planes. Defined by XYZ points of each vertex, 8x3x1
%   x       Camera location [x y z]
%   p       Point to test visibility of [x y z]


% Test vectors shorter than the vector from camera to point.
% to see if there exists some point such that the point is inside an 
% obstacle, the vector from x to that point is colinear with the vector 
% from x to p, and the vector from x to the point is shorter than the
% vector from x to p
step = .01;
test_pts = points_along_line(p, x, step);

los = true;
for n = 1:size(B, 3)
    in_obs = in_cube(test_pts, B);
    vis = ~any(in_obs);
    if ~vis
        return
    end
end

end

