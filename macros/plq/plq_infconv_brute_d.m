function [plqic, lb, argmin] = plq_infconv_brute_d(f, g, u, v, swapArgmin)
  % f = [v(1), a(1), b(1), c(1)]
  % g = [v(2), a(2), b(2), c(2)]
  %
  % f(x) = b1*x + c1 + I_[u1,v1](x)
  % g(x) = b2*x + c2 + I_[u2,v2](x)
  %
  % u1 <= x <= v1
  % u2 <= s-x <= v2
  % s-v2 <= x <= s-u2
  % max(u1, s-v2) <= x <= min(v1, s-u2)

  % inf_x [ b1*x + c1 + b2*(s-x) + c2 + I_[u1,v1](x) + I_[u2,v2](s-x) ]
  % inf_x [ (b1-b2)*x + b2*s + c1 + c2 + I... ]
  % arginf_x [ (b1-b2)*x + b2*s + c1 + c2 + I... ]
  %   = { min(v1, s-u2) if b1 <= b2,
  %     { max(u1, s-v2) if b1 >= b2.
  % min(v1, s-u2)
  %   = { s-u2 if s <= v1 + u2,
  %     { v1   if s >= v1 + u2.
  % max(u1, s-v2)
  %   = { u1   if s <= u1 + v2,
  %     { s-v2 if s >= u1 + v2.

  if (nargin < 5) 
 swapArgmin = true;  
  end;

  a = [f(1,2); g(1,2)];
  b = [f(1,3); g(1,3)];
  c = [f(1,4); g(1,4)];
  lb = u(1) + u(2);
  plqic = [];
  argmin = [];
  swapped = false;

  if (b(1) < b(2)) 

    if (swapArgmin) 

      if (u(2) ~= -inf) 

        argmin = [argmin; v(1) + u(2), 0, 1, -u(2)];
      end;
      argmin = [argmin; v(1) + v(2), 0, 0, v(1)];
      swapped = true;
    end;
    a = a([2,1]); b = b([2,1]); c = c([2,1]); u = u([2,1]); v = v([2,1]);
  end;

  % x = max(u1, s-v2)
  % inf_x [ (b1-b2)*x + b2*s + c1 + c2 + I... ]
  %   = { b2*s + (b1-b2)*u1 + c1 + c2 + I...     if s <= u1 + v2,
  %     { b2*s + (b1-b2)*(s-v2) + c1 + c2 + I... if s >= u1 + v2.
  % b2*s + (b1-b2)*(s-v2) + c1 + c2 + I...
  %   = b2*s + (b1-b2)*s - (b1-b2)*v2 + c1 + c2 + I...
  %   = b1*s - (b1-b2)*v2 + c1 + c2 + I...
  % Lower inf bound:
  %   x >= u1 & s-x >= u2
  %   x >= u1 & s >= u2+x
  %   x = u1:
  %   u1 >= u1 & s >= u2+u1
  % Upper inf bound:
  %   x <= v1 & s-x <= v2
  %   x <= v1 & s <= v2+x
  %   x = s-v2:
  %   s-v2 <= v1 & s <= v2+s-v2
  %   s <= v1+v2 & 0 <= 0

  if (u(1) ~= -inf) 

    plqic = [plqic; u(1) + v(2), 0, b(2), (b(1)-b(2))*u(1) + c(1) + c(2)];
    if (~swapped) 
 argmin = [argmin; u(1) + v(2), 0, 0, u(1)];  
    end;
  end;
  plqic = [plqic; v(1) + v(2), 0, b(1), (b(2)-b(1))*v(2) + c(1) + c(2)];
  if (~swapped) 
 argmin = [argmin; v(1) + v(2), 0, 1, -v(2)];  
  end;

  %plqic(1,:) = [u(1) + u(2), 0,    0, inf];
  %plqic(2,:) = [u(1) + v(2), 0, b(2), (b(1)-b(2))*u(1) + c(1) + c(2)];
  %plqic(3,:) = [v(1) + v(2), 0, b(1), (b(2)-b(1))*v(2) + c(1) + c(2)];
  %plqic(4,:) = [       inf, 0,    0, inf];
end