%Quick plot of one or two PLQ functions
%x1, x5 can be finite or infinity values.
function plq_plot(plqf1, plqf2, x1, x5)
    if(nargin < 2)
        plqf2 = 0;
    end
    if(nargin < 3 | x1 == -Inf) 
        x1 = -5;
    end
    if(nargin < 4 | x5 == Inf)
        x5 = 5;
    end
    
    x = linspace(x1,x5, 201);
    y1 = plq_eval(plqf1, x);
    if(~plqf2)
        plot(x, y1);
    else
        y2=plq_eval(plqf2, x);
        plot(x, y1, 'r', x, y2, 'b');
    end
    
    
end