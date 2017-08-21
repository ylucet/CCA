function b = isequal(varargin)
  % Compares whether a variable number of matrices are equal, by
  % comparing successive pairs of matrices via isEqual2.  See
  % help isEqual2 for more information.
  n = length(varargin);
  b = true;
  for i = 1:n-1
    if (~isequal2(varargin(i), varargin(i+1))) 

      b = false;
      return;
    end;
  end;
end