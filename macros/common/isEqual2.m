function b = isequal2(x, y)
  % Compares whether two matrices are equal, including infinities,
  % and, unlike isequal, tests floating point numbers properly.
  % Returns a scalar.  Returns false if the matrix contains NaNs.
  eps=1E-6;%precision under which numbers are considered equals
  if any(size(x)~=size(y)) 
 
    b=false;
  else
    i = abs(x - y) >= eps;
    if any(sign(x(i)) ~= sign(y(i))) 

  %  if or(sign(x) ~= sign(y)) then    
      b = false;
    else
      b = all(abs(x - y) < eps | (isinf(x) & isinf(y)));
    end;
  end;
end