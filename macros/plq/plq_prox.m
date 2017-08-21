%compute the proximal mapping of a PLQ function
%from the graph of the subdifferential
%only works for convex functions
function q=plq_prox(p,alpha)
  eps=1e-8;
  if alpha<0 
 cerror('alpha must be nonnegative'); 
  end;  
  G = gph_plq(p);
  P = [1 alpha;1 0] * G(1:2,:);
  P(3,:)=zeros(size(1,size(P,2)));
  q = pl_gph(P);
%  %TO DO
%  if n==2 & abs(g(1,1)-g(1,2))<eps then%singleton indicator 
%     h=g(1:2,:);
%     h(3,:)=alpha*g(3,:);
%  else
%    i=find(g==inf);
%
%    h = [1 alpha;1 0] * g(1:2,:);
%    %multiply 3rd row (values of f) alone to avoid 0*inf giving %    h(3,:)=alpha*g(3,:);
%    h(i)=inf;
%  end
end