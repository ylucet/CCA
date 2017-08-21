function plqf = plq_build_d(x,y,dy,exclude)
  %build PLQ function which is piecewise linear using the points (x(i),y(i)) and maybe dy(i)

  if (nargin < 3) 
 dy = false;  
  end;
  if (nargin < 4) 
 exclude = false;  
  end;

  infl = false;
  infr = false;
  dyType = class(dy);
  if (~isequal(dyType, 'fptr') & dy==false) 

    if (exclude) 

      while (y(1) == inf), infl = true; x = x(2:end);   y = y(2:end);    
      end;
      while (y(end) == inf), infr = true; x = x(1:end-1); y = y(1:end-1);  
      end;
    end;
    dy = (y(2:end) - y(1:end-1)) ./  (x(2:end) - x(1:end-1));
    dym=[dy(1);dy(1:end)];%left derivative at (xm,ym)
    plqf=[x,zeros(size(x)),dym,y-dym.*x];
    plqf=[plqf;inf,0,dy(end),y(end)-dy(end)*x(end)];%careful PLQ is represented with a x^2+b x + c
    if (exclude) 

      if (infl) 
 plqf(1,2:4) = [0,0,inf];  
      end;
      if (infr) 
 plqf(end,:) = [inf,0,0,inf];  
      end;
    end;
  else
    %disp([x,y,dy], "initial [x,y,dy]:");
    while (y(1) == inf | dy(1) == inf), infl = x(1); x = x(2:end);   y = y(2:end);   dy = dy(2:end);    
    end;
    while (y(end) == inf | dy(end) == inf), infr = x(end); x = x(1:end-1); y = y(1:end-1); dy = dy(1:end-1);  
    end;
    %disp([x,y,dy], "infs removed [x,y,dy]:");
    %when dy(i)==dy(i+1) remove the point x(i) since it does not give any 1st order info
    ni = find(dy(2:end)-dy(1:end-1)~=0);
    ni=[ni;length(x)];%always keep the rightmost point
    x=x(ni);y=y(ni);dy=dy(ni);
    %disp([x,y,dy], "dups removed [x,y,dy]:");
    %(xm,ym) = intersection of tangent at (x(i),y(i)) and at (x(i+1),y(i+1))
    xm=(y(1:end-1)-y(2:end)+dy(2:end).*x(2:end)-dy(1:end-1).*x(1:end-1))./ (dy(2:end)-dy(1:end-1));
    ym=y(1:end-1)+dy(1:end-1).*(xm-x(1:end-1));
    dym=dy(1:end-1);%left derivative at (xm,ym)
    %disp([xm,ym,dym], "intersection of tangents [xm,ym,dym]:");
    plqf=[xm,zeros(size(xm)),dym,ym-dym.*xm;inf,0,dy(end),y(end)-dy(end)*x(end)];%careful PLQ is represented with a x^2+b x + c
    %handle inf values or derivatives
    if (infl ~= false || ~islogical(infl)) 

      if (exclude) 

        plqf = [x(1),0,0,inf; plqf];
      else
        plqf = [infl,0,0,inf; plqf];
      end;
    end;
    if (infr ~= false || ~islogical(infr)) 

      if (exclude) 

        plqf(end,1) = x(end);
      else
        plqf(end,1) = infr;
      end;
      plqf = [plqf; inf,0,0,inf];
    end;
  end;
  plqf=plq_clean(plqf);%clean up, remove linear parts
end