function [X, varargout] = to_pinhole_img_plane(x_T, x, phi, psi, a, b, lambda)
% to_pinhole_img_plane Map points in the global reference frame to points
% in the image plane
%
% Inputs:
%   x_T         Point in workspace to map to image plane, [x; y; z]
%   x           Camera location, [x; y; z]
%   phi         Camera tilt angle, deg
%   psi         Camera pan angle, deg
%   a           Width of the camera virtual image plane
%   b           Height of the camera virtual image plane
%   lambda      Distance from pinhole to virtual image plane (focal length)
%
% [X, Y] = to_pinhole_img_plane
% Outputs:
%   X           X coordinate of point in image plane
%   Y           Y coordinate of point in image plane
%
% X = to_pinhole_img_plane
% Outputs:
%   X           Coordinates of the point in the image frame [x; y]

if numel(x) ~= 3
    error('Size of x must be 3')
end

% Ensure dimensionality of x is correct
if size(x, 1) == 1
    x = x';
end

% Replicate x to match number of points being transformed
x = repmat(x, 1, size(x_T, 2));

% Inertial to body rotation matrices
H_phi = [1 0 0; 0 cosd(phi) -sind(phi); 0 sind(phi) cosd(phi)];
H_psi = [cosd(psi) -sind(psi) 0; sind(psi) cosd(psi) 0; 0 0 1];

r_T = H_phi' * H_psi' * (x_T - x);
rx = r_T(1, :);
ry = r_T(2, :);
rz = r_T(3, :);

if nargout == 1
    X = lambda .* [rx./rz; ry./rz];
else
    X = lambda * rx ./ rz;
    varargout{1} = lambda * ry ./ rz;
end
