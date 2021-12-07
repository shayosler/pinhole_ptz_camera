function [vis] = is_pt_visible(B, x, p)
%[vis] = is_pt_visible(B, x, p) Test if a point is visible.
%
%   Tests if a point p is visible from a camera located at x, with pan and
%   tilt angles psi and phi, given obstacles defined by B. 
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
test_pts = points_along_line(p, x, .01);

vis = true;
for n = 1:size(B, 3)
    in_obs = in_cube(test_pts, B);
    vis = ~any(in_obs);
    if ~vis
        return
    end
end

end

