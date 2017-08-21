function R = plq_rock(B, k)
  %% Compute the Rockafellar PLQ function R_{A,a_k} in linear time O(m),
  %% where B: x -> conv(A*x): union(i=1:m, {a(i)} cross [bminus(i), bplus(i)].
  %% This same code is used in op.sci:op_fitzinf() to avoid having to
  %% recalculate a, bminus, bplus across multiple plq_rock() calls.
  %%
  %% B = [a; bminus; bplus];    %% a, bminus, bplus are row vectors.

  if (~all(B(1,2:end) - B(1,1:end-1) >= 0))
    [a,ak] = sort(B(1,:));
    B = [a; B(2:end,ak)];
  end;

  if (any(B(1,2:end) - B(1,1:end-1) == 0))
    cerror("plq_rock: a values are not strictly increasing.");
    R = [];
    return;
  end;

  %% Is the operator not monotonically nondecreasing?
  if (~(all(B(3,:)-B(2,:) >= 0) & all(B(2,2:end)-B(3,1:end-1) >= 0)))
    R = [inf, 0, 0, inf];
    return;
  end

  m = size(B, 2);
  k = k + 1;
  a = [-inf, B(1,:), inf];
  bm = [nan, B(2,:), nan];
  bp = [nan, B(3,:), nan];

  R = [];
  xi = 2;
  %% Precompute a sum to improve the efficiency of repeatedly
  %% computing Rockafellar functions.
  Sminus = sum((a(2:k-1) - a(3:k)) .* bm(3:k)); %% ..O(m)
  Splus = 0;

  for i = 2:m+1
    if (i <= k)
      b = bm(i);
      c = -a(i)*bm(i) + Sminus;
      Sminus = Sminus - (a(i) - a(i+1))*bm(i+1);
      R = [R; a(xi), 0, b, c];
      xi = xi + 1;
    end;

    if (i >= k)
      b = bp(i);
      c = -a(i)*bp(i) + Splus;
      Splus = Splus + (a(i+1) - a(i))*bp(i);
      R = [R; a(xi), 0, b, c];
      xi = xi + 1;
    end;
  end;
end