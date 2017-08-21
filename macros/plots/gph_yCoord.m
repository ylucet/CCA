%compute the y coordinate for the poin on the line
%going to (xi, yi) at x
function y = gph_yCoord(x, x1, y1, x2, y2)
    if x == x1
        %warning("yCoord: x == x1"); %warning message is removed to avoid warning
        y=y1;
    else
        y = (y2-y1)/(x2-x1)* (x-x1) + y1;
    end
end