function plq_plotpa_lambdaSet(plq0, plq1, x, lset, mu, rect)
    %Plot the graph of (x,lambda)->pa(f,lambda), but use plq_pa_mu which
    %supports the proximal averge of non-convex function. Varies lambda
    %with a fixed mu
    
    if(size(x, 2) > 1)
        x = x';
    end
    if(size(lset, 1) > 1)
        lset = lset';
    end
    th=1;
    clf;
    fig = gcf();
    
    %drawlater(); MAKE CURRENT FIGURE AXES CHILDREN INVISIBLE
    nc = max(round(numel(lset)/100),100);%number of colours
    cm = colormap(jet(ceil(1.1*nc))); %pad by 10% to avoid index out of bounds errors
    colorbar;
    
    i = 1; stp = ceil(numel(lset)/10);
    %beginProgress(); no scilab documentation for this (?)
    hold on
    for lambda = lset
        pa = plq_pa_mu(mu, lambda, plq0, plq1);
        y = plq_eval(pa, x);
        set(gca, 'ColorOrder', cm(ceil(lambda*nc)+1,:));
        plot(x, y);
        xlim([rect(1) rect(3)]); ylim([rect(2) rect(4)]);
        
        if mod(i, stp) == 0
            %showProgress(i/length(lset)); No scilab documentation for this (?)
        end
        
        i = i+1;
    end
    y0 = plq_eval(plq0, x); y1 = plq_eval(plq1, x);
    plot(x, y0, 'k'); plot(x, y1, 'k');
    %finishProgress(); no scilab documentation for this(?)
    %drawnow();
    hold off
end