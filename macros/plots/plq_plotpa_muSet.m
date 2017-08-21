function plq_plotpa_muSet(plq0,plq1,x,lambda,mus,rect)
    %NO CURRENT SCILAB EXAMPLE FOR THIS FUNCTION

    % Plot the graph of (x,lambda)->pa(f,lambda), but use plq_pa_mu which
    % supports the proximal average of non-convex functions.  Varies mu
    % with a fixed lambda.

    if size(x,2) >1 
        x=x';
    end
    if size(mus,1) >1
        mus=mus';
    end
  
    clf(); 
    th=1;
    fig=gcf();

    nc=max(round(numel(mus)/100),100);%number of colors
    cm = colormap(jet(ceil(1.1*nc)));
  
    colorbar(0,max(mus));
    h=gco();h.parent.FontSize=4;

    i=1;stp=ceil(numel(mus)/10);

  
    for mu=mus
        pa=plq_pa_mu(mu,lambda,plq0,plq1);
        y=plq_eval(pa,x);
    
        %the 2/%pi*atan() function sends [0,%inf] into [0,1] for plotting colors
        set(gca, 'ColorOrder', cm(ceil(2/pi*atan(mu)*nc)+1,:));
        plot(x, y);
        xlim([rect(1) rect(3)]); ylim([rect(2) rect(4)]);
        if (i==1)
            h=gca(); 
            h.FontSize=4; 
        end
        if modulo(i,stp)==0
            %showProgress(i/length(mus));
        end
        i=i+1;
    end
    %finishProgress();
    drawnow();
  end