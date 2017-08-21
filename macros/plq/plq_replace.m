function plqr = plq_replace(plqf, plqg, lb, ub)
  nf = size(plqf, 1); ng = size(plqg, 1);
  xf = plqf(:,1); af = plqf(:,2); bf = plqf(:,3); cf = plqf(:,4);
  xg = plqg(:,1); ag = plqg(:,2); bg = plqg(:,3); cg = plqg(:,4);

  if (nf == 1) 

    if (xf ~= inf & af == 0 & bf == 0) 

      cerror('plq_replace: Setting of regions in indicator functions is not supported.');
      plqr = [];
      return;
    end;
  end;

  if (ng == 1) 

    if (xf ~= inf & af == 0 & bf == 0) 

      cerror('plq_replace: Setting of regions to indicator functions is not supported.');
      plqr = [];
      return;
    end;
  end;

  i = min(find(xf >= lb));
  plqr = plqf(1:i,:);
  plqr(end,1) = lb;

  j = min(find(xg > lb));
  k = min(find(xg >= ub));
  plqr = [plqr; plqg(j:k,:)];
  plqr(end,1) = ub;

  l = min(find(xf > ub));
  plqr = [plqr; plqf(l:end,:)];
end