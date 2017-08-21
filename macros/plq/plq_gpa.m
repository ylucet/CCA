%generalized proximal average from
%W. Hare. A Proximal Average for Nonconvex Functions: 
%A Proximal Stability Perspective. SIOPT
function pa = plq_gpa(p0,p1,lambda,r)
  pa1 = plq_scalar(plq_me(p0,1/r,false), -(1-lambda));
  pa2 = plq_scalar(plq_me(p1,1/r,false), -lambda);
  pa=plq_add(pa1,pa2);
  pa=plq_me(pa,1/(r+lambda*(1-lambda)),false);
  pa=plq_scalar(pa,-1);
end