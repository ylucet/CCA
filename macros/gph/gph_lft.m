function gphstar = gph_lft(gph,check)
  %compute the conjugate
  %gph: function in gph format
  %check: boolean:   
  if nargin<2 
    check=true; 
  end;
  if check 

    [b,n] = gph_check(gph);
    if ~b 
 warning('Unconsistent gph structure in gph_lft'); 
    end;
  end      
    %do not multiply 3rd row (values of f) to avoid 0*inf giving
  gphstar = [0 1; 1 0] * gph(1:2,:);
  x = gph(1,:);s=gph(2,:);f=gph(3,:);
  gphstar(3,:)= s.*x -f;
  %fix bounded domain
  if n>2 
%no fix needed for full domain or singleton
    B = gph_isBounded(gphstar);
    if B(1,1) 
 gphstar(3,1)=inf; 
    end;
    if B(1,2) 
 gphstar(3,end)=inf; 
    end;
  end
  B = gph_isBounded(gph);
  if B(1,1) 
 gphstar(3,1)=s(1)*x(1)-f(2); 
  end;
  if B(1,end) 
 gphstar(3,end)=s(end)*x(end)-f(end-1); 
  end;    
end