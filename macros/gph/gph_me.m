function me = gph_me(gph,lambda)
  [b,n] = gph_check(gph);
  if ~b 
 warning('Unconsistent gph structure in gph_me');  
  end;
  if lambda<0 
 me=[];cerror('lambda must be nonnegative');return;  
  end; %return if lambda is not nonnegative to avoid warnings
  me = [1 lambda; 0 1] * gph(1:2,:);
  x = gph(1,:); s = gph(2,:); f = gph(3,:);
  me(3,:) = f + lambda/2*s.^2;

  if n>2 
%no fix needed for full domain or singleton
    B = gph_isBounded(gph);
    if B(1,1) 

      me(3,1) = me(3,2) - (me(1,2) - me(1,1)) * (me(2,1) + me(2,2)) / 2;

    end;
    if B(1,2) 

      me(3,end) = me(3,end-1) + (me(1,end) - me(1,end-1)) * (me(2,end-1) + me(2,end)) / 2;
    end;
  end;

  [b,m] = gph_check(me);
  if ~b 
 warning('Unconsistent gph structure resulting from gph_me');  
  end;
end