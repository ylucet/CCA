function pa = plq_pa_mu(mu, lambdas, varargin)
  % 0 <= mu <= 1
  % plq_pa_mu(mu, 0..1, f1, f2)
  % plq_pa_mu(mu, [0.3,0.7], f1, f2)
  % plq_pa_mu(mu, [0.1,0.3,0.6], f1, f2, f3)
  %printf("pla_ma_mu( 
  n = length(varargin);

  if (length(lambdas) == 1 & length(varargin) == 2) 

    lambdas = [1-lambdas, lambdas];
  end;
  if (length(lambdas) ~= n) 

    cerror('plq_pa_mu: length(lambdas) must equal the number of functions.  (Or have one lambda, two functions.)');
    pa = []; return;
  end;
  if (abs(sum(lambdas) - 1) > 1E-6) 

    cerror('plq_pa_mu: sum(lambdas) must equal 1.');
    pa = []; return;
  end;

  pa = plq_scalar(plq_me(varargin{1}, mu, false), lambdas(1));
  for i = 2:n
    f = varargin{i};
    if (lambdas(i) ~= 0) 

      pa = plq_add(pa, plq_scalar(plq_me(f, mu, false), lambdas(i)));
    end;
  end;
  pa = plq_scalar(plq_me(plq_scalar(pa, -1), mu, false), -1);
end