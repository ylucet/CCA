function plq_plotgpa(plq0,plq1,x,lset,r,rect,animate,generateGIF,gifFilename)
    %wrapper to avoid code duplication
    if(nargin < 7)
        animate = 0;
    end
    if(nargin < 8)
        generateGIF = 0;
    end
    if(nargin < 9)
        gifFilename = "animate.gif";
    end
    isConvex = 0; %always assume nonconvex for gpa
    L={plq0, plq1}; %use {} to create cell array, matlab doesn't have scilab 'list()'
    plq_plotEnv('gpa',L,x,lset,r,rect,isConvex,animate,generateGIF,gifFilename);

end