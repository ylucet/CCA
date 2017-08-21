function [fmin,xmin]=plq_minPt(p)
  %minimum point of a plq function
  %compute the minimum value fmin and point xmin=argmin (potentially mutivalued)
  %of a plq function p
  %p: plq function
  %fmin: real. value of the minimum (could be -inf or inf)
  %xmin: column vector containing all the points where the minimum is attained (could be empty)
  %xmin is returned in nondecreasing order 
  %WARNING: if the argmin set is not discrete i.e. it is an interval,
  %then only returns the boundary of the interval
  fmin=inf;xmin=[];bd=[];
  if size(p,1) > 1 
 bd = p(1:end-1,1); 
  end;
  a=p(1:end,2);b=p(1:end,3);qmin=[];
  i = find(a~=0);
  qmin = -b(i) ./  (2*a(i));%candidate minima inside quadratic parts
  %check that qmin is inside interval
  ubmin=p(:,1);ubmin=ubmin(i);
  lbmin=[-inf;p(1:end-1,1)];lbmin=lbmin(i);
  if ~isempty(qmin) 
%avoid error find([]<=[])
    i=find(qmin<=ubmin);
    qmin=qmin(i);
    lbmin=lbmin(i);
    if ~isempty(qmin) 

      i=find(qmin>=lbmin);
      qmin=qmin(i);
    end
  end
  call = [bd;qmin];%candidate minima
  if isempty(call) 

    %no boundary point: 1 piece + no quadratic part => linear function or indicator of point
    if p(1,1)==inf 
%linear function
      if p(1,3)==0 
%constant function
	fmin = p(1,4);xmin=[0];
      else
	fmin = -inf;xmin=[];
      end
    else      fmin = p(1,4);xmin=p(1,1);
    end    
  else
    call=sort(call);%plq_eval require sorted data
    pcan = plq_eval(p,call);    
    [fmin,imin]=min(pcan);%only returns one index
    imin = find(pcan==fmin);%find all argmin
    xmin = sort(call(imin));
  end  
end