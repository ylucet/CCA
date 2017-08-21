function F = plq_fitzinf0(B)
  % Compute F[A,inf](., 0) = max[a] R[A,a](.)
  %                         = max[1<=k<=m] R[a_k](.)
  % where B: x -> conv(A*x): union(i=1:m, {a(i)} cross [bminus(i), bplus(i)].
  %
  % B = [a; bminus; bplus];    % a, bminus, bplus are row vectors.
  %
  % This is an optimized version of plq_fitzinf0_direct,
  % which runs in big-theta(m) time.

  if (~all(B(1,2:end) - B(1,1:end-1) >= 0)) 

    [a,k] = sort(B(1, 'descending'));
    B = [a; B(2:end,k)];
  end;

  if (any(B(1,2:end) - B(1,1:end-1) == 0)) 

    cerror('op_fitzinf0: a values are not strictly increasing.');
    F = [];
    return;
  end;

  % Is the operator not monotonically nondecreasing?
  if (~(all(B(3,:)-B(2,:) >= 0) & all(B(2,2:end)-B(3,1:end-1) >= 0))) 

    F = [inf, 0, 0, inf];
    return;
  end;

  m = size(B, 2);
  a = [-inf; B(1,:)'; inf];
  bm = [-inf; B(2,:)'; inf];
  bp = [-inf; B(3,:)'; inf];

  % Todo: Use binary searches.
  j0 = max(find(bm < 0));
  j1 = max(find(bp < 0));

  S1 = sum((a(2:j0-1) - a(3:j0)) .* bm(3:j0));
  S2 = 0;

  % Compute F[A,inf].  O(m)
  F = [];
  for i = 1:m+1
    plqx = a(i+1);    % a(i) < x < a(i+1)

    if (j0 > i) 

      % Case 2: R_{a_{j_0}}
      %printf("plq_fitzinf0, i =       plqb = bm(i+1);
      plqc = -a(i+1)*bm(i+1) + S1;
      S1 = S1 - (a(i+1) - a(i+2)) * bm(i+2);
    else
      if (i-1 >= j1+1) 

        S2 = S2 + (a(i) - a(i-1)) * bp(i-1);
        plqc = S2;
        %printf("Sum       else
        plqc = 0;
        %printf("No sum       end;

      if (j0 < i) 

        % Case 1: R_{a_{j_1 + 1}}
        %printf("plq_fitzinf0, i =         plqb = bp(i);
        plqc = plqc - a(i)*bp(i);
      elseif (bp(i) == bm(i+1) | i == m+1) 

        % Case 3: R_{a_{j_1 + 1}}
        %printf("plq_fitzinf0, i =         plqb = bp(i);
        plqc = plqc - a(i)*bp(i);
      else
        % Case 4: R_{a_{j_1 + 1}} then R_{a_{i+1}}
        %printf("plq_fitzinf0, i =         if (i ~= 1) 

          xbar = (a(i)*bp(i) - a(i+1)*bm(i+1)) / (bp(i) - bm(i+1));
          plqb = bp(i);
          plqc = plqc - a(i)*bp(i);
          F = [F; xbar, 0, plqb, plqc];
        end;

        plqb = bm(i+1);
        plqc = -a(i+1)*bm(i+1);
      end;
    end;

    F = [F; plqx, 0, plqb, plqc];
  end;

  F = plq_clean(F);
end