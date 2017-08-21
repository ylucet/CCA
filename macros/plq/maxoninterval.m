%calculates the max between two functions that do not intersect within the given interval.
function [plq,i] = maxoninterval(q1,q2,lb,ub,a,b,c)
    if all(isinf([lb,ub])) 
 
        m=0;%pick any point
    else%at most one bound is infinite
        lb1=lb;ub1=ub;
        if lb==-inf 
            lb1=ub-1; 
        end;
        if ub==inf 
            ub1=lb+1; 
        end;
        m=(lb1+ub1)/2;%midpoint
    end;
  %printf(" Maxoninterval: q1=[    
  if a*m.^2+b*m+c > 0 
    plq = [ub,q1]; i = 1; %assumes (q1 - q2) = qld
 else
     plq = [ub,q2];
     i = 2;
 end;
end
%%%%%%%%%%%%FINDS THE MAXIMUM OF TWO PLQ FUCNTIONS%%
