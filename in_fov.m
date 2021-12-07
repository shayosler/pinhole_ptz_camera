function [vis] = in_fov(x_T, x, phi, psi, a, b, lambda)
% in_fov Determing if points are within the camera FOV
%
% Inputs:
%   x_T         Point in workspace to check, [x; y; z]
%   x           Camera location, [x; y; z]
%   phi         Camera tilt angle, deg
%   psi         Camera pan angle, deg
%   a           Width of the camera virtual image plane
%   b           Height of the camera virtual image plane
%   lambda      Distance from pinhole to virtual image plane (focal length)
%
% Outputs:
%   vis     True if x_T is in field of view

% Transform points from inertial frame to the image plane
x_img = to_pinhole_img_plane(x_T, x, phi, psi, a, b, lambda);

% Camera FOV is centered on the origin of the image plane, check if points
% fall within the rectangular sensor area
in_x = abs(x_img(:, 1)) < (a / 2);
in_y = abs(x_img(:, 2)) < (b / 2);
vis = in_x & in_y;


