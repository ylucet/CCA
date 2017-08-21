function plq_plotEnv(envFlag,L,x,lset,r,rect,isConvex,animate,generateGIF,gifFilename)
    %plot the graph of (x,lambda)->pa(f,lambda) in the current graphic window
    %2d graph with colors for each value of lambda
    %L: list. If envFlag=='pa' or 'gpa' then L is a list of 2 plq functions. plq0=L(1);plq1=L(2);
    %         If envFlag=='ka' then L is a list of 4 (Scilab) functions: f1=L(1),df1=L(2),f2=L(3),df2=L(4),g=L(5),dg=L(6)
	%x: column vector
	%lset: row vector; lset is the lambda set i.e. the values of lambda from 0 to 1
	%rect: rect option passed to plot2d
	%isConvex: %t (default) if functions are convex (faster to compute)
	%animate: %t shows curve as they are plotted (default %f)
	%generateGIF uses ImageMagicks from www.ImageMagick.org to create an animated GIF
	%gifFilename: name of the GIF file (default: animate.gif) created in the current directory
    
    %Testing for generating animations and gifs has not been conducted yet.
    %Hence setting the below three arguments to false
    generateGIF = 0; gifFilename = 0; animate = 0;
    
    
    if generateGIF
        %clean up any *.gif file in tempdir
        stat = unix("rm " + tempdir + "/*.gif");
        %add .gif if not already in name
        addSuffix = 0;
        if(length(gifFilename) < 3)
            addSuffix = 1;
        end
        if(~addSuffix)
            suffix = strsplit(gifFilename, length(gifFilename) -3);
            if(suffix(end) ~="gif")
                addSuffix = 1;
            end
        end
        if addSuffix
            gifFilename = gifFilename+".gif";
        end
    end
    
    if(size(x, 2) > 1)
        x=x';
    end
    if(size(lset,1) > 1)
        lset = lset';
    end
    th=1; 
    if ~generateGIF
        %drawlater(); NO SCILAB DOCUMENTATION FOR THIS
    end
    nc = max(round(numel(lset)/100),100); %number of colours
    cm = colormap(jet(ceil(1.1*nc)));
    
    
    %figure; 
    colorbar;
    %h=gco();h.FontSize=4;
    hold on
    
    %TRY TO CREATE GIF PROPERLY
    if generateGIF
        h = getframe;
        [im, map] = rgb2ind(h.cdata,256, 'nodither');
    end
    
    i=1; stp=ceil(numel(lset)/10);
    %beginPrgress(); No scilab documentation for this
    for lambda=lset
        if(envFlag=="pa")
            pa=plq_pa(L{1},L{2}, lambda, isConvex);
            y=plq_eval(pa, x);
        elseif(envFlag=="gpa")
            pa=plq_gpa(L{1}, L{2}, lambda, r);
            y = plq_eval(pa, x);
        elseif(envFlag=="ka")
            then
            y = opt_ka(L{1}, L{2}, L{3}, L{4}, L{5}, L{6}, x, lambda);
        else
            error("Unrecognized option: Flag %s is not a valid flag for envFlag in _plq_plotEnv",envFlag);
        end
        
        set(gca, 'ColorOrder', cm(ceil(lambda*nc)+1,:));
        plot(x, y)
        xlim([rect(1) rect(3)]); ylim([rect(2) rect(4)]);
        
        if generateGIF
            s = sprintf("%s/img%03.0f.gif", tempdir, i);
            %if i ==1 then printf("%s\n",s); pause; end
            %TRY TO MAKE GIF
            h = getframe;
            im(:,:,1, numel(lset)) = rgb2ind(f.cdata, map, 'nodither');
        end
        %if (i==1) then h=gca(); h.FontSize=4; end
        if(mod(i, stp) == 0)
            %showProgress(i/length(lset));
            if animate & ~generateGIF 
                drawnow();
                %drawlater();
            end
        end
        i=i+1;
    end
    %finishProgress();
    
    %GIF:
    if generateGIF
        imwrite(im, map, s, 'DelayTime', 0, 'LoopCount', Inf);
        
        %requires ImageMagicks from www.ImageMagick.org
        stat = unix("convert -delay 10 " + tempdir + "/*.gif " + gifFilename);
    else
        drawnow();
    end
    
    if(envFlag=="pa")
        y1 = plq_eval(L{1}, x); y2 = plq_eval(L{2}, x);
        plot(x, y1, 'k'); plot(x, y2, 'k');
    end
    
    hold off
end