% This function processes a function containing a QLQ segment, where the
% linear piece is converging to the convex hull of the quadratics.  Given
% the index i of the linear piece, it removes it, interpolating the
% quadratics to their intersection point.  It returns the new function,
% and the index of the left quadratic piece.
function [plqf, i] = plq_conv_qlq(plqf, i)
    j = i + 1;
    i = i - 1;
    A = plqf(i,2) - plqf(j,2);
    B = plqf(i,3) - plqf(j,3);
    C = plqf(i,4) - plqf(j,4);
    x1 = -plqf(i,4) / plqf(i,3);
    x5 = -plqf(j,4) / plqf(j,3);

    % Calculate the intersection point.
    if A == 0 

        x = -C/B;
    else
        D = B*B - 4*A*C;
        if D < 0 

            cerror('_plq_conv_qlq: Unable to intersect parabolas.  Impossible case?');
        end;
        pr = (-B + sqrt(D)) / (2*A);
        nr = (-B - sqrt(D)) / (2*A);
        if x1 <= pr <= x5 

            x = pr;
        elseif x1 <= nr <= x5 

            x = nr;
        else
            cerror('_plq_conv_qlq: Intersection not parabola vertices.  Impossible case?');
        end;
    end;

    plqf(i,1) = x;
    plqf(i+1,:) = [];
end