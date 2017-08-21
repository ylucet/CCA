%extend the graph to boundary values by linear extrapolation
%only return the first 2 rows and discard the 3rd row
function G = gph_extendGph(g, rect)
    if g(1,1) == g(1,2) %vertical line on left %ERROR HERE
      G=[[g(1,1);rect(2)],g(1:2,:)];
    else
        G=[[rect(1); gph_yCoord(rect(1),g(1,1),g(2,1),g(1,2),g(2,2))],g(1:2,:)];
    end
    if(g(1,end)==g(1, end-1)) %vertical line on right
        G=[G, [g(1, end); rect(4)]];
    else
        G=[G, [rect(3); gph_yCoord(rect(3),g(1,end-1),g(2,end-1),g(1,end),g(2,end))]];
    end
end