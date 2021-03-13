%% Convert cartesian points to Longitude/Latitudinal Points
% Takes in 4 parameters (points, distance, lat, lon)
% points: cartesian coordinates of all the points on the Hilbert Curve
% distance: Distance in km. of length away from the starting point. 
% lat: Latitudinal coordinate of home location
% lon: Logitudinal coordinate of home location

% Returns: coordinate points of hilbert curve in geographic coordinates
function coordinate = convert_h(points, distance, lat, lon)

%rescale to distance
max_x = max(points, [], 'all');
scale = (1/max_x)*distance;
points = points.*scale;

points = points';
values = length(points); %number of points that need to be moved
x = points(1,1);
y = points(2,1);

%See if the distance between the waypoints are greater than 0.8 km
fir = points(:, 1);
sec = points(:, 2);
val = max(sec-fir);
div = ceil(val/0.8);
num_col = div*(values-1)+ 1;
coordinate = zeros(2, num_col);
coordinate(:, 1) = [x; y];
coor_i = 2;

%Divide up waypoints if distance are greater than 0.8 km
if val > 0.8
    for i = 2:values
        count = 1;
        x_diff = round(points(1, i)-points(1, i-1),5);
        y_diff = round(points(2, i)-points(2, i-1), 5);
        while count < div
            x_val = coordinate(1, coor_i-1);
            y_val = coordinate(2, coor_i-1);
            if y_diff == 0 && x_diff > 0
                coordinate(2, coor_i) = y_val;
                coordinate(1, coor_i) = x_val+0.8;
            elseif y_diff == 0 && x_diff < 0
                coordinate(1, coor_i) = x_val-0.8;
                coordinate(2, coor_i) = y_val;
            elseif x_diff == 0 && y_diff>0
                coordinate(1, coor_i) = x_val;
                coordinate(2, coor_i) = y_val+0.8;
            elseif x_diff == 0 && y_diff<0
                coordinate(1, coor_i) = x_val;
                coordinate(2, coor_i) = y_val-0.8;
            end
            count = count+1;
            coor_i = coor_i + 1;
        end
            coordinate(1, coor_i) = points(1, i);
            coordinate(2, coor_i) = points(2, i);
            coor_i = coor_i + 1;
    end
else
    coordinate = points;
end

% After finishing Hilbert curve, return to original position

iter = floor(distance/0.8);
new = zeros(2, iter);
for i = 1:iter
    new(1, i) = distance - i*0.8;
end

coordinate = [coordinate, new]; %concatenating original path and return home


num_col = length(coordinate);
%lat/long conversion
start = [lat; lon; 0];
for i = 1:num_col
    x_move = coordinate(1, i)*1000;
    y_move = coordinate(2, i)*1000;
    [lat_pt, lon_pt] = local2latlon(x_move, y_move, 50, start);
    coordinate(1,i) = lat_pt;
    coordinate(2,i) = lon_pt;
end

