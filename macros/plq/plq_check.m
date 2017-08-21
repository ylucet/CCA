function [b,er]=plq_check(p,ind)
  %check that p is a plq function
    %1: check x is increasing
  %2: check p is continuous
  %b: boolean true if tests are successful, false otherwise
  %er: maximum error found in the last test run.
  if nargin<2 
    ind=[1 2]; 
  end;
  eps=1E-6;
  b=true;
  er=0;
  if find(ind==1) 
 %check that x is increasing
    x=p(:,1);
    if x(end)==inf 
        x(end)=[]; 
    end;
    dx=x(2:end)-x(1:end-1);
    er=min(dx);
    b = b & all(er>0);
  end
  if find(ind==2) 
 %check that p is continuous
    q=p;
    if p(1,4)==inf 
 q(1,:)=[]; 
    end;%domain is left bounded
    if p(end,4)==inf 
 q(end,:)=[]; 
    end;%domain is right bounded
    x=q(1:end-1,1);
    yleft  = q(1:end-1,2).*x.^2+q(1:end-1,3).*x+q(1:end-1,4);
    yright = q(2:end,2).*x.^2+q(2:end,3).*x+q(2:end,4);
    er = max(abs(yleft-yright));
    b = b & er < eps;
  end
end