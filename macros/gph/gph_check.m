function [b,n] = gph_check(gph,testConvex)
  %false if gph structure violates requirements; true otherwise
  %gph: gph function
  %testConvex: boolean; true means check gph is convex, false means do not test convexity
  %b: boolean; true is structure test passes; false otherwise
  %n: column dimension of gph
  eps=1e-6;
  if nargin<2 
 testConvex=true; 
  end;
  n = size(gph, 2);
  if (size(gph,1) ~= 3) 

    b = false;%gph should be a 3xn matrix
  elseif n<=1 

    b=false;%n should be n>1
  elseif n==2 

    x0=gph(1,1);
    x1=gph(1,2);
    s0=gph(2,1);
    s1=gph(2,2);
    f0=gph(3,1);
    f1=gph(3,2);
    if abs(x1-x0)>eps 

        b=true;%full domain: OK
    else       b = all([(abs(s0-s1)>eps&abs(f0-f1)<eps)]);
    end
  else
    %bounded domain should return inf for function value
    b = all([(gph(1,1) == gph(1,2)) == (gph(3,1) == inf); ...
       (gph(1,end-1) == gph(1,end)) == (gph(3,end) == inf)]);
    %gph(1,:) should be nondecreasing
    b = all([b ;all(gph(1,2:end) - gph(1,1:end-1) >= 0)]);
    %gph(2,:) should be nondecreasing for convex gph
    if testConvex 
   
      b = all([b ;all(gph(2,2:end) - gph(2,1:end-1) >= 0)]);
    end      
    %check continuity of f
    x=gph(1,:); s=gph(2,:); f=gph(3,:);
    d = f(2:end-1) + (x(3:end) - x(2:end-1)) .* (s(3:end) + s(2:end-1)) / 2;    e = f(2) + (x(1) - x(2)) * (s(1) + s(2)) / 2;                 %except the first piece
    pl_bb = [abs(e - f(1)) <= eps, abs(d - f(3:end)) <= eps];
    Er = [abs(e - f(1)), abs(d - f(3:end))];%error matrix
    if gph(3,1)==inf & gph(1,1)==gph(1,2) 
 pl_bb(1)=true;Er(1)=0;  
    end;
    if gph(3,end)==inf & gph(1,end)==gph(1,end-1) 
 pl_bb(end)=true;Er(end)=0;  
    end;
          %warning(sprintf("_gph_check: f is not continuous. Max error:     %end;
    b = b & all(pl_bb);
  end
end