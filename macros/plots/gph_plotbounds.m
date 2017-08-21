function rect = gph_plotbounds(L)
    m=[ Inf; Inf];
    M = -m;
    for g=1:length(L) %need to access like L{1}, L{2},..., L{i}
        m = min([L{g}(1:2,:) m], [], 2);
        M = max([L{g}(1:2,:) M], [], 2);
    end
    %add 10% to extrapolation with min value of 1
    % slack = [0;0]; % no slack (for testing)
    slack = 0.1* (max([M-m, [1;1]], [], 2));
    xmin = m(1)-slack(1);xmax=M(1)+slack(1);
    ymin = m(2)-slack(2);ymax=M(2)+slack(2);
    rect=[xmin, ymin, xmax, ymax];
end