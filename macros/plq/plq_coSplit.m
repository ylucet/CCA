function plqco = plq_coSplit(plqf)
  % Compute the convex hull of a PLQ function by breaking it into pieces,
  % using the formula:
  %     co p = (max (pi)*)*
  %     where pi is the ith piece of p, +inf outside of the piece's domain,
  %     and * is the conjugate.

  if size(plqf,1) == 1 

    % Special case: point indicator.
    if plqf(1,1) ~= inf 

      plqco = plqf;
      return;
    end;
    
    % The convex hull of a single-piece function will be itself, unless
    % it is a concave quadratic.
    if plqf(1,2) < 0 

      plqco = [inf, 0, 0, -inf];
    else
      plqco = plqf;
    end;
    return;
  end;

  % Special case: f -> -inf as x -> +/-inf.
  if plqf(1,2) < 0 | plqf(end,2) < 0 ...
      | (plqf(1,2)==0 & plqf(end,2) == 0 & plqf(end,3) < plqf(1,3)) 

    plqco = [inf, 0, 0, -inf];
    return;
  end;
  
  % Keep an accumulator for the maximum conjugate.
  acc = [inf, 0, 0, -inf];
  
  for i = 1:size(plqf,1)
    cnj = plq_split(plqf, i);
    if ~plq_check(cnj) 
 printf('plq_coSplit: Invalid cnj.'); pause;  
    end;
    
    % Special case: concave down quadratic.
    % Replace it with a linear interpolation between its two endpoints.
    if cnj(2,2) < 0 

      x0 = cnj(1,1);
      x1 = cnj(2,1);
      y0 = cnj(2,2)*x0.^2 + cnj(2,3)*x0 + cnj(2,4);
      y1 = cnj(2,2)*x1.^2 + cnj(2,3)*x1 + cnj(2,4);
      a = (y1 - y0) / (x1 - x0);
      b = y0 - x0 * a;
      cnj(2,2:4) = [0,a,b];
    end;

    acc = plq_max(acc, plq_lft(cnj));
    if ~plq_check(acc) 
 printf('plq_coSplit: Invalid acc.'); pause;  
    end;
  end;
  
  plqco = plq_lft(acc);
end