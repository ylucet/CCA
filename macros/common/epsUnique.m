function [Xu,ku] = epsUnique(X,eps,keepLast)
  %remove all indices i that are nonunique up to epsilon
    %ku are the indices that are kept i.e. unique up to eps
    %only exception is when keepLast==  %last index
  if nargin<3 
 keepLast=false; 
  end;
  Y = round(X / eps);
  [Yu,ku]=unique(Y);
  n = length(X);
  if keepLast & ku(end)==n-1 

    %replace last unique index with last index
    ku(end)=n;
  end
  Xu = X(ku);
end