function q=plq_ll(p,lambda,mu)
  %Lasry-Lions double envelope (has same inf and argmin as p)
  % 0< mu < lambda
  q = plq_me(p,lambda,false);
  q = plq_scalar(q,-1);
  q = plq_me(q,mu,false);
  q = plq_scalar(q,-1);
end