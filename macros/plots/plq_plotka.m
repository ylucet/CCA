function plq_plotka(f1,df1,f2,df2,g,dg,x,lset,rect,animate,generateGIF,gifFilename)
    %wrapper to avoid code duplication
    if(nargin < 10)
        animate = 0;
    end
    if(nargin < 11)
        generateGIF = 0;
    end
    if(nargin < 12)
        gifFilename = "animate.gif";
    end
    r=1;isConvex=0; 
    %WARNING: pass f1, df1, f2, df2, g, dg, by dynamic scoping
    L = {f1, df1, f2, df2, g, dg};
    plq_plotEnv('ka',L,x,lset,r,rect,isConvex,animate,generateGIF,gifFilename);
end