function [pts] = points_along_line(start, stop, step)
%[pts] = points_along_line(start, end, step) generate a set of points at a
%   specified interval along a line
%
%   Get a set of points at the specified spacing along a line segment. The
%   first point will be step units past start along the line

% Check dimensions: ensure that start and stop are 1xN e.g. [x y z] or [x y]
if size(start , 1) ~= 1 
    start = start';
end

if size(stop, 1) ~= 1
    stop = stop';
end

% Sanity check, step size must be shorter than the line segment
l_line = norm(stop - start);
if step >= l_line
    pts = [];
    return
end

% Get unit vector from start to stop
u = (stop - start) / l_line;

% Get the step vector
step_v = step .* u;

% Generate points
p = start + step_v;
l = norm(p - start);
pts = [];
while l < l_line
    pts = [pts; p];
    p = p + step_v;
    l = norm(p - start);
end

end

