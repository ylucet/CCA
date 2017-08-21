%TO DO: TEST
%compute the proximal mapping of a GPH function
%from the graph of the subdifferential
%only works for convex functions
function Q = gph_prox(G,alpha)
  if alpha<0 
 Q=[]; cerror('alpha must be nonnegative'); 
  end;
  eps=1e-8;
  P = [1 alpha;1 0] * G(1:2,:);
  P(3,:)=zeros(size(1,size(P,2)));
  %convert subdifferential to piecewise linear function  
  q = pl_gph(P);
  Q = gph_plq(q);
end
