function [dc_plq] = plq_deconv_lft(plqf,plqg)
  fstar = plq_lft(plqf);
  gstar = plq_lft(plqg);
  neg_gstar = plq_scalar(gstar,-1);
  fstar_minus_gstar = plq_add(fstar,neg_gstar);
  [dc_plq] = plq_lft(fstar_minus_gstar);
end