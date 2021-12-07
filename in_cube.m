function [in] = in_cube(p, C)
%in_cube Test if a point is in a cube.
%   Test if points lie within cubes whose faces are aligned with the
%   XY, XZ, and YZ planes. This function returns false for points that lie
%   on the face of the cube
% Inputs:
%   p       Points to test Mx3 [x1 y1 z1;...;xm ym zm]
%   C       matrix of vertices defining the cubes 6x3xN
%
% Output
%   in      MxN logical matrix, in(m,n) will be true if point p(m, :) m 
%           lies in the cube C(:, :, n)

in = false(size(p, 1), size(C, 3));

for n = 1:size(C, 3)
    max_x = max(C(:, 1));
    min_x = min(C(:, 1));
    
    max_y = max(C(:, 2));
    min_y = min(C(:, 2));
    
    max_z = max(C(:, 3));
    min_z = min(C(:, 3));
    in_cube = false(size(p));
    in_cube(:, 1) = p(:, 1) > min_x & p(:, 1) < max_x;
    in_cube(:, 2) = p(:, 2) > min_y & p(:, 2) < max_y;
    in_cube(:, 3) = p(:, 3) > min_z & p(:, 3) < max_z;
    in(:, n) = all(in_cube, 2);
end
end

