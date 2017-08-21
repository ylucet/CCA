function gph = gph_plq(plq)
  % Converts a plq model to a gph model.

  m = size(plq,1);
  n = size(plq,2);
  if m == 1 

    if isinf(plq(1,1)) 
%function defined everywhere: [inf a b c]
      x0=-1;x1=1;a=plq(1,2);b=plq(1,3);c=plq(1,4);
      gph = [x0 x1;2*a*x0+b 2*a*x1+b;a*x0.^2+b*x0+c a*x1.^2+b*x1+c];
    else      x0=plq(1,1);f0=plq(1,4);
      gph = [x0 x0;-1 1;f0 f0];
    end      
    return;
  end;

  %bounded domain: remove inf parts (add them back at the end)
  plqc=plq;%copy plq
  if plq(1,4) == inf 

    plqc(1,2:4)=plqc(2,2:4);%extend linearly on left
  end
  if plq(end,4) == inf 

    plqc(end,2:4)=plqc(end-1,2:4);%extend linearly on right
  end
  m = size(plqc,1);  n = size(plqc,2);

  % Don't need the +inf in x.
  x = plqc(1:end-1,1);  a = plqc(:,2);  b = plqc(:,3);  c = plqc(:,4);

  % Calculate the left and right slopes of the PLQ intervals.
  Sl = 2 * a(1:end-1) .* x + b(1:end-1);
  Sr = 2 * a(2:end) .* x + b(2:end);


  % Build up a gph with every x value duplicated, with first
  % its left slope, then its right.  Then uniquify to remove
  % duplicate points.  Ignore the unbounded regions for now.
  % Set X = [x(1),x(1), x(2),x(2), ..., x(n),x(n)].
  X = reshape([x, x]', 1, (m-1)*2);
  % Set S = [Sl(1),Sr(1), Sl(2),Sr(2), ..., Sl(n),Sr(n)].
  S = reshape([Sl'; Sr'], 1, (m-1)*2);
  % Set F = [eval(plq,x(1)), eval(plq,x(1)), ..., eval(plq,x($)), eval(plq,x($))]
  %     where eval(plq, x) = the lower limit of plq at x (e.g. for indicators).
  F = [a(1:end-1) .* x .^ 2 + b(1:end-1) .* x + c(1:end-1), ...
       a(2:end) .* x .^ 2 + b(2:end) .* x + c(2:end)];
  F = min(F, [], 2)';
  F = reshape([F; F], 1, (m-1)*2);

  % Create gph and make the columns unique.
  gph = [X; S; F];
  [gph2, I] = unique(gph([1 2],:)', 'rows');%only works in Scilab 5
  gph2 = gph2';
  I = I';
 
  gph = [gph2; gph(3,I)];

  % Add on the left and right unbounded regions.
  % x(0) cannot be x(1)-1 if plq(x)==inf for x<x(1).
  % Likewise when plq(x)==inf for x>x($).
  if plq(1,4) == inf 

    x0 = x(1);  s0 = S(1) - 1;  f0 = inf;
  else
    x0 = x(1) - 1;
    s0 = 2 * a(1) * x0 + b(1);
    f0 = a(1) * x0.^2 + b(1) * x0 + c(1);
  end

  if plq(end,4) == inf 

    x9 = x(end);  s9 = S(end) + 1;  f9 = inf;
  else
    x9 = x(end) + 1;
    s9 = 2 * a(end) * x9 + b(end);
    f9 = a(end) * x9.^2 + b(end) * x9 + c(end);
  end

  gph = [[x0;s0;f0], gph, [x9;s9;f9]];
end
