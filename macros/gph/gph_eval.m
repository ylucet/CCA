function Z = gph_eval(gph, X)
  %evaluate the gph function gph on the NONDECREASING column vector X
  Z=[];
  if isempty(X)
    return;  
  end;  
  isDebug=false;
  if size(X,2) ~= 1 

      cerror('gph_eval: X should be a column vector.');
  end;
  %do NOT test _gph_check since some gph functions are NOT convex e.g. proximal mapping is monotone nonconvex
%  if ~_gph_check(gph,  
  % Integrates the subdifferential gph to give the value
  % of the corresponding PLQ function at each X value.
  if ~isempty(X) 
    n = size(gph, 2);
    if n == 2 & gph(1,1) == gph(1,2) 
    % Special case: Point indicator.
      Z = zeros(size(X)) + inf;
      Z(find(X == gph(1,1))) = gph(3,1);
      return;
    end;

    I = pl_fusionsci(gph(1,:)', X);
    X = X';  I = I';
    I(find(I == 1)) = 2;
    % Guarantee that X > gph(1,I) by incrementing I's as necessary.
    % _pl_fusion(sci) doesn't guarantee to be above the left bound.
    gph2 = [gph, [nan;nan;nan]];   
     J = find(X == gph2(1,I) & I < n+1);
    while ~isempty(J)
        I(J) = I(J) + 1;
        J = find(X == gph2(1,I) & I < n+1);
    end;
    I(find(I == n + 1)) = n;
    % X(i) is between gph(1,I(i)-1) inclusive and gph(1,I(i)) exclusive.
    % Z(i) = gph(3,I(i)) - int_{X(i)<x<gph(1,I(i))} (height of gph at x)

    % Duplicate values in X, in gph(1,:), and between the two, are handled:
    % 1. X(i) == X(j) is fine because each X(i) is independantly assigned an 
    % I(i) from _pl_fusionsci, and the pieces the X(i)'s land in are integrated
    % separately for each X(i).
    % 2. We ensure by the loop above, that when X(i) == gph(1,j)
    % [or, gph(1,j-1)<=X(i)<gph(1,j)], that I(i)=j.
    % Integration is done rightward (subtracting) from
    % gph(3,j) to X(i), so gph(1,j-1)-X(i)=0 is never calculated, because
    % gph(1,j)-X(i)>0 is used instead.
    % 3. Finally, gph(1,j-1) == gph(1,j) is fine because _pl_fusionsci will never
    % find an X(i) strictly between two equal numbers.
    m = (gph(2,I) - gph(2,I-1)) ./  (gph(1,I) - gph(1,I-1));
    S = gph(2,I) - m .* (gph(1,I) - X);
    area = (gph(2,I) + S) .* (gph(1,I) - X) / 2;
    Z = (gph(3,I) - area)';

    % Enforce lower-semicontinuity if upper-bounded.
    if gph(3,end) == inf 

      Z(find(X == gph(1,end))) = gph(3,end-1);
    end
    % Enforce lower-semicontinuity if lower-bounded.
    if gph(3,1) == inf 

      Z(find(X == gph(1,1))) = gph(3,2);
    end
  end

  if isDebug 
 
    p=plq_gph(gph);
    y=plq_eval(p,X);
    if ~isequal(y,Z) 
 printf('G eval pb'); 
    end;
  end
    
end
