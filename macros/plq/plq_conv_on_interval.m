%We assume x(1) < x(2) < x(3) < x(4) < x(5) are ordered and finite (no infinity values). 
%In creating the PLQ hull we may need to create points x(2) and x(4).
%Note that x(1) is the LEFTBOUND, x(3) is the partition point, and x(5) is the RIGHTBOUND in our PLQ interval. 
%_plq_conv_on_interval finds the convex hull on the interval [x1,x5].
function [plqco] = plq_conv_on_interval(f1,f2,x1,x3,x5) %Assume f1 is to the left of f2
  x(1) = x1; a(1)=f1(1,2); a(2)=f2(1,2);
  x(3) = x3; b(1)=f1(1,3); b(2)=f2(1,3);
  x(5) = x5; c(1)=f1(1,4); c(2)=f2(1,4);
  plqco=[];
  
  if a(1) < 0 
  %concave down pieces are simply replaced by a linear function.
      f1=plq_conv_buildl(x,a,b,c,1,1,1,3);
      f2=[x(5),a(2),b(2),c(2)];
      plqco=plq_conv_on_interval(f1,f2,x(1),x(3),x(5));
  elseif a(2) < 0 

      f1=[x(3),a(1),b(1),c(1)];
      f2=plq_conv_buildl(x,a,b,c,2,5,2,3);
      plqco=plq_conv_on_interval(f1,f2,x(1),x(3),x(5));
  elseif 2*a(1)*x(3)+b(1) <= 2*a(2)*x(3)+b(2) 
 %trivial case
      plqco=[x(3),a(1),b(1),c(1);x(5),a(2),b(2),c(2)];
  elseif a(1) == 0 & a(2) == 0 
 %(LINEAR-LINEAR) f1 is linear and f2 is linear.
      [plqco]=plq_conv_buildl(x,a,b,c,1,1,2,5);
  elseif a(1) == 0 & a(2) ~=  0 
 % (LINEAR-QUDARTIC) if f1 is linear and f2 is quadratic then x(4) is determined.
      plqco=[conv_interval_func(x,a,b,c,x1,x3,x5)];
  elseif a(1) ~=  0 & a(2) == 0 
 % (QUADRATIC-LINEAR) if f1 is quadratic and f2 is linear then x(2) is determined.
      plqco=[conv_interval_func(x,a,b,c,x1,x3,x5)];
  elseif a(1) ~=  0 & a(2) ~=  0 
 % (QUADRATIC-QUADRATIC) if f1 is quadratic and f2 is quadratic we need to find solutions to A*x(4)^2 + B*x(4) + C.
      %The following code solves [PROBLEM 1.], 
      A=(1/4)*(-4*a(2).^2+4*a(2)*a(1))/a(1);
      B=(1/4)*(-4*a(2)*b(2)+4*b(1)*a(2))/a(1);
      C=(1/4)*(-b(2).^2-b(1).^2+4*c(1)*a(1)+2*b(1)*b(2)-4*c(2)*a(1))/a(1);
      D = B.^2 - 4*A*C; %Discriminant.
      %printf("QUADRATIC-QUADRATIC CASE: Solving      
      if A == 0 
 %Linear case, so we have Bx+C=0 with one zero.
          x(4) = (-C/B);
          x(2) = (-1/2)*(b(1)-2*a(2)*x(4)-b(2))/a(1);
          if x(2) < x(1) | x(3) < x(2) 
 x(2)=inf;  
          end;
          if x(4) < x(3) | x(4) > x(5) 
 x(4)=inf;  
          end;
            %and thus we should just ignore them. Similarly if D < 0, just ignore x(2) and x(4) as they don't help with the hull. 
      else % A <> 0, Quadratic case, so we have Ax^2+Bx+C=0, with one or two zeros. Solving for x(4).
            if D>0 

                nr = (-B - sqrt(D))/(2*A); %negative root
                pr = (-B + sqrt(D))/(2*A); %positive root
                if D==0 
                    nr=pr;  
                end;
                if x(3) < pr & pr < x(5) 
                    x(4) = pr;
                elseif x(3) < nr & nr < x(5) 
                     x(4) = nr; %printf(" NEGATIVE ROOT ");
                else x(4)=inf; end;
                x(2) = (-1/2)*(b(1)-2*a(2)*x(4)-b(2))/a(1);
                if x(1) > x(2) | x(2) > x(3) 
                    x(2)=inf;  
                end;
            else
                x(2)=inf; x(4)=inf;
            end
      end
      if x(2) < inf & x(4) < inf 
          plqco=[x(2),a(1),b(1),c(1);plq_conv_buildl(x,a,b,c,1,2,2,4);x(5),a(2),b(2),c(2)];
      else %x(2) == inf | x(4) == inf, 
         %Here we solve the SECOND PROBLEM: as x(2) or x(4) is infeasible in [PROBLEM 1.]
          plqco=[conv_interval_func(x,a,b,c,x1,x3,x5)];
      end;
  else cerror('Case does not exist.');
  end
end
