%%%%%%%%%%%%%%PLQ SCALAR MULTIPLCATION FUNCTION%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function q = plq_scalar(p,lambda)
  %avoid 0 * inf
  i=find(p==inf);j=find(p==-inf);
  q = [p(:,1), lambda*p(:,2:4)];
  %restore inf values;
  if lambda >= 0 
   
    q(i)=inf;
  else 
    q(i)=-inf;
    %careful not to mess up indicator of singleton
    if p(end,1)==inf 
 q(end,1)=inf; 
    end;
  end;
  if lambda >= 0 
   q(j)=-inf; else q(j)=inf; 
  end;
  %need to clean AFTER restauring values otherwise the index i
  %does not correspond to the cleaned matrix that may have less rows.
  q = plq_clean(q);
end
%%%%%%%%%%%%%%PLQ SCALAR MULTIPLCATION%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%