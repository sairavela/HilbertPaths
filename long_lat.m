%% TXT file of all waypoints
% Change parameter on hilbert curve for order
% Change parameter on numerical values of convert_h
% Creates txt file with waypoints to be used as input in the python file to
% make the file plan for QGC

points = hilbercurve(2); %order

% The parameter points should not be changed
position = convert_h(points, 3, 47.8, 8); %(points, distance, lat, lon)

x = position(1,:);
y = position(2,:);

writematrix(position, 'positions.txt');
type 'positions.txt';