function h = gph_scalar(g,alpha)
  [b,n] = gph_check(g);
  if ~b 
 cerror('Unconsistent gph structure in gph_scalar'); 
  end;
  if alpha<0 
 cerror('alpha must be nonnegative in graph-reshape calculus'); 
  end;
  eps=1e-8;
  if n==2 & abs(g(1,1)-g(1,2))<eps 
%singleton indicator 
     h=g(1:2,:);
     h(3,:)=alpha*g(3,:);
  else
    i=find(g==inf);
    h = [1 0;0 alpha] * g(1:2,:);
    %multiply 3rd row (values of f) alone to avoid 0*inf giving     
    h(3,:)=alpha*g(3,:);
    h(i)=inf;
  end
end