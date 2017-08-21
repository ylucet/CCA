%Plot mutiple PLQ functions
%x1, x5 can be finite or infinity values
function plq_plotMultiple(x1, x5, varargin)
    if(nargin < 1 | x1 == false | x1 == -Inf)
        x1 = Inf;
        for i = 1:length(varargin)
            f = varargin{i};
            lb = max(1, min(find(f(:,4) ~= Inf)) -1);
            x1 = min(x1, f(lb, 1));
        end
        if(isinf(x1))
            x1 = -5;
        end
        spaceLeft = 1;
    else
        spaceLeft = 0;
    end
    if(nargin < 2 | x5 == false | x5 == Inf)
        x5 = - Inf;
        for i = 1:length(varargin)
            f = varargin{i};
            ub = max(find(f(:,4) ~= Inf));
            x5 = max(x5, f(ub,1));
        end
        if(isinf(x5))
            x5 = 5;
        end
        spaceRight = 1;
    else
        spaceRight = 0;
    end
    if(length(varargin) == 0)
        return;
    end
    spacing = (x5 - x1) * 0.15;
    x = linspace(x1-spacing*spaceLeft, x5+spacing*spaceRight, 200)';
    y = [];
    %TODO: Plot indicator functions spcially: plot2d(f(1,1), f(1,4), -5);
    for i = 1:length(varargin)
        f = varargin{i};
        y(:, i) = plq_eval(f, x);
    end
    plot(x, y)
end