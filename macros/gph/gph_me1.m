%works but requires gph_prox. Can we do better?
function gphstar = gph_me1(gph,lambda)
  [b,n] = gph_check(gph);
  if ~b 
 cerror('Unconsistent gph structure in gph_me1'); 
  end;
  %do not multiply 3rd row (values of f) to avoid 0*inf giving   gphstar = [1 lambda; 0 1] * gph(1:2,:);
  x = gph(1,:)';%s=gph(2,:);f=gph(3,:);
  Prox = gph_prox(gph,lambda);

  prox = gph_eval(Prox,x);
  fprox = gph_eval(gph,prox);

  gphstar(3,:)= (fprox + (x-prox).^2/(2*lambda))';
%  %TO DO: fix bounded domain
%  if n>2 then%no fix needed for full domain or singleton
%    B = gph_isBounded(gphstar);
%    if B(1,1) then gphstar(3,1)=inf;end;
%    if B(1,2) then gphstar(3,$)=inf;end;
%  end
%  B = gph_isBounded(gph);
%  if B(1,1) then gphstar(3,1)=s(1)*x(1)-f(2);end;
%  if B(1,$) then gphstar(3,$)=s($)*x($)-f($-1);end;    
end