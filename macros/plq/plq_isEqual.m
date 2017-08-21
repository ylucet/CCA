%test whether 2 plq functions are equal
%use the clean function to round small values
%and contrary to the isEqual function compacts small intervals
function b = plq_isEqual(p1,p2)
  %remove common inf values to prevent inf-inf=NaN
  isP1inf=(p1(end,1)==inf);
  isP2inf=(p2(end,1)==inf);
  large=realmax;
  i1=find(p1==inf);
  i2=find(p2==inf);
  p1(i1)=large;
  p2(i2)=large;
  i1=find(p1==-inf);
  i2=find(p2==-inf);
  p1(i1)=-large;
  p2(i2)=-large;  
  %restore plq format without screwing indicator of a point special case
  if isP1inf 
 p1(end,1)=inf; 
  end;
  if isP2inf 
 p2(end,1)=inf;end
  %compute difference of both functions and test it is the zero function
  q = plq_clean(plq_add(p1,plq_scalar(p2,-1)));
  if all([size(p1,1)==1,size(p2,1)==1,~isinf(p1(1,1)),~isinf(p2(1,1))]) 

    %SPECIAL CASE: 2 indicators of singleton
    b = norm(p1-p2) < 1E-6;
  else
    b = all(q==[inf 0 0 0]);
  end
end