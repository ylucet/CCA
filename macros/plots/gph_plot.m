%plot the subdifferential graph of an unknown number of gph functions
%(limit of 5 gph functions)
%automatically compute the display window and extrapolate to its boundary
%see gph_version for utility functions _gph_plotbounds_gph_yCoord,_gph_extendGph
function gph_plot(varargin)
    if(isempty(varargin))
        error("No argument given to gph_plot function");
    end
    if(length(varargin)==1)
        L=[varargin];
    else
        L=varargin;
    end
    rect = gph_plotbounds(varargin); %%FIX THIS
    %need to plot graph by graph since graphs may not have same number of points
    
    hold on
    %make a vector with the different symbols, colours, and thickness's so as to have multiple plots all unique
    %limit up to 5
    %NOT WORKING
    spec = ['-xr';'-+b';'-sg';'-*m';'-ok';'-dc'];
    for i=1:length(varargin)
        g = varargin{i};
        G = gph_extendGph(g, rect); %%extend graph to boundary by linear extrapolation
        %added figure to hold multiple plots
        plot(G(1,:)',G(2,:)', spec(i,:));
        %plot(G(1,:)',G(2,:)', spec(i+1));
        xlim([rect(1) rect(3)]); ylim([rect(2) rect(4)]);
    end
    hold off
end