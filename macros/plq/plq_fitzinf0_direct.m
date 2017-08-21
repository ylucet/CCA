function F = plq_fitzinf0_direct(B)
  % Compute F[A,inf](., 0) = max[a] R[A,a](.)
  %                         = max[1<=k<=m] R[a_k](.)
  % where B: x -> conv(A*x): union(i=1:m, {a(i)} cross [bminus(i), bplus(i)].
  %
  % B = [a; bminus; bplus];    % a, bminus, bplus are row vectors.

  if (~all(B(1,2:end) - B(1,1:end-1) >= 0)) 

    [a,k] = sort(B(1, 'descending'));
    B = [a; B(2:end,k)];
  end;

  if (any(B(1,2:end) - B(1,1:end-1) == 0)) 

    cerror('op_fitzinf0_direct: a values are not strictly increasing.');
    F = [];
    return;
  end;

  % Is the operator not monotonically nondecreasing?
  if (~(all(B(3,:)-B(2,:) >= 0) & all(B(2,2:end)-B(3,1:end-1) >= 0))) 

    F = [inf, 0, 0, inf];
    return;
  end;

  F = [inf, 0, 0, -inf];
  F = plq_rock(B, 1);
  for k = 2:size(B, 2)
    R = plq_rock(B, k);   % Linear.
    F = plq_max(F, R);    % Linear.  plq_max (plq_oploop actually) cleans F.
  end;
end