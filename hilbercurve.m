%% Hilber Curve Function
% Takes in one parameter, n (order of hilbert curve)
% Returns: hilbert curve in cartesian points
function points = hilbercurve (n)
A = zeros(0,2);
B = zeros(0,2);
C = zeros(0,2);
D = zeros(0,2);

north = [ 0  1];
east  = [ 1  0];
south = [ 0 -1];
west  = [-1  0];

order = n;
for index = 1:order
  AA = [B ; north ; A ; east  ; A ; south ; C];
  BB = [A ; east  ; B ; north ; B ; west  ; D];
  CC = [D ; west  ; C ; south ; C ; east  ; A];
  DD = [C ; south ; D ; west  ; D ; north ; B];

  A = AA;
  B = BB;
  C = CC;
  D = DD;
end

points = [0 0; cumsum(A)];
end