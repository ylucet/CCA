function plq = plq_gph(gph)
  % Converts a gph model to a plq model.
  %special cases:
  if size(gph,2)==1 
 error('plq_gph: gph data does not correspond to a plq function');return; 
  end;
  if size(gph,2)==2 

      eps=1e-8;
      x0=gph(1,1);
      x1=gph(1,2);
      s0=gph(2,1);
      s1=gph(2,2);
      f0=gph(3,1);
      f1=gph(3,2);
      
      if abs(x1-x0)>eps 
%full domain
        a=(s1-s0)/(2*(x1-x0));b=s0-2*a*x0;pl_bb=s1-2*a*x1;
        if abs(b-pl_bb)>eps 
 error('plq_gph: convertion error! Coefficient b not constant'); 
        end;        
        c=f0-a*x0.^2-b*x0;cc=f1-a*x1.^2-b*x1;
        if abs(c-cc)>eps 
 error('plq_gph: convertion error! Coefficient c not constant'); 
        end;
        plq=[inf a b c];
      else if abs(s0-s1)<eps | abs(f0-f1)>eps 
        error('plq_gph: convertion error! Unconsistent indicator function'); 
        end;
        plq=[x0 0 0 f0];
      end;
      return;
  end
  
  x0 = gph(1,1:end-1);
  x1 = gph(1,2:end);

  % A non-vertical line segment in the subdifferential corresponds
  % to the derivative 2ax + b of the PLQ function.  Thus 2a is the
  % slope and b is the Y-intercept.
  A = (gph(2,2:end) - gph(2,1:end-1)) ./  (x1 - x0) / 2;
  B = gph(2,1:end-1) - 2*A.*x0;
  C = gph(3,1:end-1) - A.*x0.^2 - B.*x0;
  X = [x0(1,2:end), inf];

  plq = [X', A', B', C'];
  if gph(3,1) == inf 
 plq(1,[2 3 4]) = [0, 0, inf];  
  end;
  if gph(3,end) == inf 
 plq(end,[2 3 4]) = [0, 0, inf];  
  end;
  I = find(X(1:end-1) == X(2:end));
  if ~isempty(I)
 plq(I+1,:) = [];  
  end;
  plq=plq_clean(plq);
end
