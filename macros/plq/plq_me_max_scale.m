function scale = plq_me_max_scale(varargin)
  n = length(varargin);
  scale = inf;
  for i = 1:n
    f = varargin{i};
    a = f(:,2);
    b = f(:,3);
    if (a(1) < 0) 
 scale = min(scale, -1/2/a(1));  
    end;
    if (a(end) < 0) 
 scale = min(scale, -1/2/a(end));  
    end;
  end;
end