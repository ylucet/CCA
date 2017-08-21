function I=plq_dom(p)
  %compute the domain (set of points x at which p(x) is finite)
  %p: plq function having a connected domain
  %I: 1x2 matrix storing an interval I=[lb,ub]
    if size(p,1)==1 & ~isinf(p(1,1)) 
 I=[p(1,1),p(1,1)];  else%bounded, left-bounded, right-bounded and full domains
    if isinf(p(1,4)) 
 I(1,1)=p(1,1); else I(1,1)=-inf; 
    end;
    if isinf(p(end,4)) 
 I(1,2)=p(end-1,1); else I(1,2)=inf; 
    end;
  end
end