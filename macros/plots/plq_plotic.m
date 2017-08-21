function [plqic, argmin] = plq_plotic(plqf, plqg, swapArgmin, plotArgmin)
    if(nargin < 3)
        swapArgmin = 1;
    end
    if(nargin < 4)
        plotArgmin = 0;
    end
    
    [plqic, argmin] = plq_infconv_brute(plqf, plqg, swapArgmin, plotArgmin);
    
    %min/max not supported with more than two matrices and dimensions not supported in matlab
    %x0 = min(plqf(1,1), plqg(1,1), plqic(1,1));
    x0 = min(plqf(1,1), plqg(1,1));
    x0 = min(plqic(1,1), x0);
    x1 = max(plqf(end-1,1), plqg(end-1,1));
    x1 = max(plqic(end-1,1), x1);
    ax0 = argmin(1,1); ax1 = argmin(end-1,1);
    figure; clf;
    plq_plotMultiple(x0, x1, plqf, plqg, plqic);
    xlabel("f, g, infconv(f,g)")
    figure; clf;
    plq_plotMutiple(ax0, ax1, argmin);
    xlabel("Proximal mapping of infconv(f,g)")
end