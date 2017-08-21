%build a linear function, f1i, is the function index, and x1i is the x-value we wanted to evaluate the function on.
%similarly f2i is the function index of the second function, and x2i corresponds to the value we evaluate the function on.
%In other words constructs a linear function from (x1i,f[f1i](x(x1i))), to (x(x2i),f[f2i](x(x2i))).
%function [plq_fctn] = _plq_conv_build2(x,a,b,c)
function [l_fctn]=plq_conv_buildl(x,a,b,c,f1i,x1i,f2i,x2i),

     %printf(" x(x1i)=     
     %The case used most often is the PLQ convex hull on a bounded interval [x(1),x(5)].  
     if x(x1i) > -inf & x(x2i) < inf 
 %LOWER BOUNDRY IS FINITE, UPPER BOUNDRY IS FINITE
          y1 = a(f1i)*x(x1i).^2 + b(f1i)*x(x1i) + c(f1i);
          y2 = a(f2i)*x(x2i).^2 + b(f2i)*x(x2i) + c(f2i);
          m = (y2-y1)/(x(x2i)-x(x1i)); %slope
          i = -x(x1i)*m + y1;           l_fctn = [x(x2i),0,m,i];
     elseif x(1) == -inf & x(5) == inf 
 %LOWER BOUNDRY IS UNBOUNDED, UPPER BOUNDRY IS UNBOUNDED
          if a(1) ~=  0 & a(2) ~=  0 
 cerror('_plq_conv_buildl: CASE D.N.E. (1)'); %D.N.E, as x(2), & x(4) exist
          elseif a(1) ~=  0 & a(2) == 0 
 %special
              x(2)=-1/2*(b(1)-2*a(2)*x(3)-b(2))/a(1);
              y1 = a(1)*x(2).^2+b(1)*x(2)+c(1);
              m=2*a(2)*x(3)+b(2);
              i=-x(2)*m+y1;
              l_fctn=[x(2),a(1),b(1),c(1);x(5),0,m,i];
          elseif a(1) == 0 & a(2) ~=  0 
 %special
              x(4) = 1/2*(-b(2)+2*a(1)*x(3)+b(1))/a(2);
              y2 = a(2)*x(4).^2 + b(2)*x(4) + c(2);
              m=2*a(1)*x(3) + b(1);
              i=-x(4)*m + y2;
              l_fctn=[x(4),0,m,i;x(5),a(2),b(2),c(2)];
          elseif a(1) == 0 & a(2) == 0 
 %D.N.E, as plqco=[inf,0,0,-inf]
          else cerror('_plq_conv_buildl: Case does not exist');
          end;
     elseif x(1) == -inf & x(5) < inf 
 %LOWER BOUNDRY IS UNBOUNDED, UPPER BOUNDRY IS FINITE
          if a(1) ~=  0 & a(2) ~=  0 
 cerror('_plq_conv_buildl: CASE D.N.E (2)'); %D.N.E, as x(2), & x(4) exist
          elseif a(1) ~=  0 & a(2) == 0 
 cerror('_plq_conv_buildl: CASE D.N.E (3)'); %D.N.E, as x(2) exists
          elseif a(1) == 0 & a(2) ~=  0 
 %special
              x(4) = 1/2*(-b(2)+2*a(1)*x(3)+b(1))/a(2);
              y2 = a(2)*x(4).^2 + b(2)*x(4) + c(2);
              m=2*a(1)*x(3) + b(1);
              i=-x(4)*m + y2;
              l_fctn =[x(4),0,m,i;x(5),a(2),b(2),c(2)];
          elseif a(1) == 0 & a(2) == 0 
 
              l_fctn = [x(5),0,b(1),-x(5)*b(1)+(b(2)*x(5)+c(2))]; %special
          else cerror('_plq_conv_buildl: Case does not exist');
          end;
     elseif x(1) > -inf & x(5) == inf 
 %LOWER BOUNDRY IS FINITE, UPPER BOUNDRY IS UNBOUNDED
          if a(1) ~=  0 & a(2) ~=  0 
 cerror('_plq_conv_buildl: CASE D.N.E. (4)'); %D.N.E, as x(2), & x(4) exist
          elseif a(1) ~=  0 & a(2) == 0 
 %special
              x(2) = (b(2)-b(1))/2*a(1);
              y2 = a(1)*x(2).^2 + b(1)*x(2) + c(1);
              m=b(2);
              i=-x(2)*m + y2;
              l_fctn =[x(2),a(1),b(1),c(1);x(5),0,m,i];
          elseif a(1) == 0 & a(2) ~=  0 
 cerror('_plq_conv_buildl: CASE D.N.E. (5)'); %D.N.E, as x(4) exists
          elseif a(1) == 0 & a(2) == 0 
 %special
              l_fctn=[inf,0,b(2),-x(1)*b(2)+(b(1)*x(1)+c(1))];
          else cerror('_plq_conv_buildl: CASE D.N.E. (6)');
          end;
     else cerror('_plq_conv_buildl: CASE D.N.E. (7)');
     end
end
