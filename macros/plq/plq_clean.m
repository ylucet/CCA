%%%%%%%%%PLQ CONJUGATE HELPER FUNCTION%%%%%%%%%%%%%
function [plqClean] = plq_clean(plqDirty)  
  eps=1E-6;%1E-6;precision below which numbers are rounded to zero
  % a Temporary Vector or matrix to check presence of infinite
  dplq=plqDirty(2:end-1,:)-plqDirty(1:end-2,:);
  %clear duplicate point values e.g [0,1,0,1;0,2,0,0] -> [0,1,0,1]
  j1=find(abs(dplq(:,1))<eps);%delete j1+1
  if length(j1)>0 
    plqDirty(j1+1,:)=[]; 
  end;
  
  dplq=plqDirty(2:end,:)-plqDirty(1:end-1,:);
  %clear duplicate rows e.g. [0,1,0,0;0,1,0,0]->[0,1,0,0]
  if size(dplq,1)==1 
      tempnum = dplq(1,2:end);        %Since norm doesn't take infinite argument, replace it with a large number
      knan = isnan(tempnum);
      kinf = isinf(tempnum);
      tempnum(knan) = 1E10;
      tempnum(kinf) = 1E10;
    if norm(tempnum)<eps 
 plqDirty(1,:)=[];  
    end;
  else    
    m=abs(dplq(:,2:end))*ones(size(dplq(:,2:end), 2), 1);
    n=abs(plqDirty(1:end-1,2:end))*ones(size(plqDirty(1:end-1,2:end), 2), 1);
    i=find(n==inf | n==0);n(i)=1;%no division by inf
    m=m./ n;%use relative error
    j2=find(m<eps);
    plqDirty(j2,:)=[];    
  end
  %round small numbers to zero
  %this should be done by the clean function
  %but clean is buggy when the matrix contains inf 
  %P1=plqDirty(:,2:$)
  P1=plqDirty;
  P=reshape(P1,[numel(P1), 1]);
  ni=find(abs(P)<eps);
  P(ni)=0;
  P1=reshape(P,size(P1));
  %plqDirty(:,2:$)=P1;
  plqDirty=P1;
  %Mike
  %Addition of infinity values results in functions like
  %  [x x x x]
  %  [x x x inf]
  %  [x x x xinf]
  %  [inf x  x inf]
  %However it is properly represented as
  %  [x x x x]
  %  [inf x  x inf]
  %The following lines of code remove the redundant infinity rows.

  plqInf = plq_rowalwaysinf(plqDirty);
  [rs,cs] = find(all([plqInf(1:end-1,:), plqInf(2:end,:)], 2));
  if (size(rs,1) ~= 0) 

    plqDirty(rs+1,2:end-1) = 0;  % If rs==[], then rs+1==[1],
    plqDirty(rs,:) = [];       %  we want rs+1==[], hence the if.
  end
  %bounded domains are represented as x0,0,0,inf so force the zeros in
  if (plqDirty(1,4)==inf) 
 plqDirty(1,2:3)=0; 
  end;
  %(same for xn,0,0,inf)
  if (plqDirty(end,4)==inf) 
 plqDirty(end,2:3)=0; 
  end;
  plqClean = plqDirty;
end
%%%%%%%%%PLQ CONJUGATE HELPER FUNCTION%%%%%%%%%%%%%
