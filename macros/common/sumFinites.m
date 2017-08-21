function n = sumFinites(x)
  % Returns the sum of the finite numbers in the matrix x.

  b = ~isinf(x) & ~isnan(x);
  n = sum(x(b));
end