function [vis] = in_fov(x_T, x, phi, psi, a, b, lambda)
% in_fov Determing if a point is within the camera FOV
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


