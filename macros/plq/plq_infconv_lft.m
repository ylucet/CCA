function [ic_plq] = plq_infconv_lft(plqf,plqg)
  fstar = plq_lft(plqf);
  gstar = plq_lft(plqg);
  fstar_plus_gstar = plq_add(fstar,gstar);
  [ic_plq] = plq_lft(fstar_plus_gstar);
end