function gph = gph_add(gph1, gph2)
  % Special case: adding a point indicator function.
  if size(gph2,2) == 2 & gph2(1,1) == gph2(1,2) 
	  t=gph1; gph1=gph2; gph2=t;    % Put the indicator in gph1.
  end;
  if size(gph1,2) == 2 & gph1(1,1) == gph1(1,2) 
	  z = gph1(3,1) + gph_eval(gph2, gph1(1,1));
	  gph = gph1;
	  gph(3,:) = [z z];
	  return;
  end;

    %Special case: adding 2 fully defined functions
    if size(gph2,2)==2 && size(gph1,2)==2 
        x = (gph2(1:2,1)+gph2(1:2,2))/2;
        gph2 = [gph2(:,1) [x; gph_eval(gph2, x(1))] gph2(:,2)];%add one more point to gph2
        gph = gph_add(gph1, gph2);%recursive call cannot enter the current if statement
        return 
    end

  % Ignore the boundary pieces, until the very end,
  % where we attach them to the resulting gph.
  X1 = gph1(1,2:end-1);
  X2 = gph2(1,2:end-1);
  X = unique([X1, X2]);
  % Find the index of each X in gph1 and gph2.
  I1 = pl_fusionsci(X1', X');
  I2 = pl_fusionsci(X2', X');
  % These are the slopes of the subdifferentials in the regions that each
  % X(i) maps into in both gph1 and gph2.
  m1 = (gph1(2,I1+1) - gph1(2,I1)) ./  (gph1(1,I1+1) - gph1(1,I1));
  m2 = (gph2(2,I2+1) - gph2(2,I2)) ./  (gph2(1,I2+1) - gph2(1,I2));
  % At each X value, compute the left and right limits of the sum.
  % Put the right limits "below" the left limits, then reshape to get "beside".
  SR = gph1(2,I1) + gph2(2,I2);
  J = find(X ~= gph1(1,I1)); SR(J) = SR(J) + m1(J) .* (X(J) - gph1(1,I1(J)));
  J = find(X ~= gph2(1,I2)); SR(J) = SR(J) + m2(J) .* (X(J) - gph2(1,I2(J)));
  % X matches up with gph1(:,I1) and gph2(:,I2).  If, for In > 1, X ==
  % gphn(1,In-1), then set SL += gphn(2,In-1) - gphn(2,In) to adjust SL to
  % have the left slope at X.
  SL = SR;
  J = find(I1 > 2);
  if ~isempty(J) 

    K = find(X(J) == gph1(1,I1(J)-1));
    if ~isempty(K) 

      SL(J(K)) = SL(J(K)) + gph1(2,I1(J(K))-1) - gph1(2,I1(J(K)));
    end;
  end;
  J = find(I2 > 2);
  if~isempty(J) 

    K = find(X(J) == gph2(1,I2(J)-1));
    if ~isempty(K) 

      SL(J(K)) = SL(J(K)) + gph2(2,I2(J(K))-1) - gph2(2,I2(J(K)));
    end;
  end;
  % Build gph.
  F = (gph_eval(gph1, X') + gph_eval(gph2, X'))';
  gph = [X;SL;F ; X;SR;F];
  % Reshape gph from (6 x n) to (3 x 2n).
  gph = reshape(gph, 3, size(gph,2)*2);
  % It could be that gph.{s(i) = -inf, f(i) = inf} for all i < j if j > 1
  % and gph1(1,j) is below gph2's lower bound.  Or it may be that gph(1,1)
  % = -inf if both gph1,gph2 are unbounded below.  In both cases, we want
  % to delete those columns.
  gph(:,find(any(isinf(gph)))) = [];    % Remove columns with infinite x's.
  gph = unique(gph', 'rows')';

  % Add the unbounded regions.sci
  % First determine the lower and upper x bounds.
  lb = -inf; ub = inf;
  if gph1(1,1) == gph1(1,2) 
 lb = max(lb, gph1(1,1));  
  end;
  if gph2(1,1) == gph2(1,2) 
 lb = max(lb, gph2(1,1));  
  end;
  if gph1(1,end-1) == gph1(1,end) 
 ub = min(ub, gph1(1,end));  
  end;
  if gph2(1,end-1) == gph2(1,end) 
 ub = min(ub, gph2(1,end));  
  end;

  if lb ~= -inf 

    gph = [gph(:,1) + [0; -1; inf], gph];
  else
    % Both functions are unbounded below.
    x0 = gph(1,1) - 1;
    s0 = gph1(2,2) + (x0 - gph1(1,2)) * ((gph1(2,2) - gph1(2,1)) / ...
                                         (gph1(1,2) - gph1(1,1)));
    s0 = s0 + gph2(2,2) + (x0 - gph2(1,2)) * ((gph2(2,2) - gph2(2,1)) / ...
                                              (gph2(1,2) - gph2(1,1)));

    lower = [x0; s0; gph_eval(gph1,x0) + gph_eval(gph2,x0)];
    gph = [lower, gph];
  end;

  if ub ~= inf 

    gph = [gph, gph(:,end) + [0; 1; inf]];
  else
    % Both functions are unbounded above.
    x9 = gph(1,end) + 1;
    s9 = gph1(2,end-1) + (x9 - gph1(1,end-1)) * ((gph1(2,end) - gph1(2,end-1)) / ...
                                             (gph1(1,end) - gph1(1,end-1)));
    s9 = s9 + gph2(2,end-1) + (x9 - gph2(1,end-1)) * ((gph2(2,end) - gph2(2,end-1)) / ...
                                                  (gph2(1,end) - gph2(1,end-1)));
    upper = [x9; s9; gph_eval(gph1,x9) + gph_eval(gph2,x9)];
    gph = [gph, upper];
  end;
end
