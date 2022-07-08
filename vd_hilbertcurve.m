
function points = vd_hilbertcurve(bl_n, tl_n, tr_n, br_n, size)
xyflip = [0 1; 1 0];
negxyflip = [0 -1; -1 0];

n = max([bl_n tl_n tr_n br_n]);

if n == 1
   points =  [0 0 1 1; 0 1 1 0];
   return;
end

BL = hilbertcurve(bl_n, 1);
BL =  BL * 1/2;
BL = xyflip * BL;

TL = hilbertcurve(tl_n, 1);
TL = TL * 1/2;
TL = TL + repmat([0; 1], 1, length(TL));

TR = hilbertcurve(tr_n, 1);
TR = TR * 1/2;
TR = TR + repmat([1; 1], 1, length(TR));


brflipoffset = [((2^n - 1)/(2^(n - 1)));(2^(n-1) - 1)/(2^(n-1))];
BR = hilbertcurve(br_n, 1);
BR = BR * 1/2;
BR = negxyflip * BR;
BR = BR + repmat(brflipoffset, 1, length(BR));

out = [BL TL TR BR];
points = out * size;

end