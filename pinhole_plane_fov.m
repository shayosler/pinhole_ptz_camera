function [V] = pinhole_plane_fov(x, phi, psi, a, b, lambda)
% [V] = pinhole_fov(X, phi. psi) Get the 4 points defining the field of 
%   view of a pinhole camera in the z = 0 plane
%
% Inputs:
%   x           Camera location, [x; y; z]
%   phi         Camera tilt angle, deg
%   psi         Camera pan angle, deg
%   a           Width of the camera virtual image plane
%   b           Height of the camera virtual image plane
%   lambda      Distance from pinhole to virtual image plane (focal length)
%
% Outputs:
%   V           3x4 matrix of x and y coordinates of camera FOV   

if numel(x) ~= 3
    error('Size of x must be 3')
end

if size(x, 1) == 1
    x = x';
end

% Inertial to body rotation matrices
H_phi = [1 0 0; 0 cosd(phi) -sind(phi); 0 sind(phi) cosd(phi)];
H_psi = [cosd(psi) -sind(psi) 0; sind(psi) cosd(psi) 0; 0 0 1];

% Scale factors
rho = zeros(4,1);
rho(1) = -x(3) / ( (b/2) * sind(phi) + lambda * cosd(phi) );
rho(4) = rho(1);
rho(2) = -x(3) / ( -(b/2) * sind(phi) + lambda * cosd(phi) );
rho(3) = rho(2);

q_B = [a/2 b/2 lambda; a/2 -b/2 lambda; -a/2 -b/2 lambda; -a/2 b/2 lambda]';

V = zeros(size(q_B));
for l = 1:4
    q_I = inv(H_psi*H_phi)' * q_B(:, l);
    q_I_prime = rho(l) .* q_I;
    V(:, l) = x + q_I_prime;
end

end

