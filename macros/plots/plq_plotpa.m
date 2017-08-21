function plq_plotpa(plq0,plq1,x,lset,rect,isConvex,animate,generateGIF,gifFilename)
    %wrapper to avoid code duplication
    if(nargin < 6) 
        isConvex = 1;
    end
    if(nargin < 7)
        animate = 0;
    end
    if(nargin < 8)
        generateGIF = 0;
    end
    if(nargin <9)
        gifFilename = "animate.gif";
    end
    r=1; %unneeded for plq_pa
    L = {plq0, plq1};
    plq_plotEnv('pa',L,x,lset,r,rect,isConvex,animate,generateGIF,gifFilename);
end