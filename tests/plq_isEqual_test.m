function tests = plq_isEqual_test()
tests = functiontests(localfunctions);
end



function b = test1(testCase)
  %domain is split
  p1=[inf 1 0 0];
  p2=[0 1 0 0;inf 1 0 0];
  b=plq_isEqual(p1,p2);
  %small values
  eps=1e-12;
  p2=[inf 1+eps eps -eps];
  b=b & plq_isEqual(p1,p2);
  %small values + split partitions
  p2=[-eps 1 0 eps;eps 1-eps -eps/10 0;inf 1 -eps eps/1000];
  b=b & plq_isEqual(p1,p2);
  p1=[1 0 0 1];
  b=plq_isEqual(p1,p1);
  p2=[1 0 0 1+eps];
  b=plq_isEqual(p1,p2);
assert(b) ;
end

function b= test2(testCase)
  p = [-1 0 0 inf;1 0 0 0 ;inf 0 0 inf];  
  b = plq_isEqual(p,p);  
assert(b) ;
end

function b= test3(testCase)
  p = [-1 0 0 -inf;1 0 0 0 ;inf 0 0 -inf];  
  b = plq_isEqual(p,p);  
assert(b) ;
end

function b= test4(testCase)
  p = [1 0 0 -4];q=[inf 0 0 -4];
  b = ~plq_isEqual(p,q);  
assert(b) ;
end

function b=test5(testCase)
  x=linspace(-2,2,4)';
  function y=f0(x),y=x.^4;end
  function y=df0(x),y=4*x.^3;end
  p0 = plq_build(x,@f0,@df0,false,false,'soqs','bounded');
  p1 = [inf,1,-2,1];
  f1=p0;
  f2=p1;
  lambda=0.5;
  rplq = plq_pa(f1,f2,lambda);
  G1=gph_plq(f1);
  G2=gph_plq(f2);
  G = gph_pa(G1,G2,lambda);
  rgph = plq_gph(G);
  rplq=plq_clean(rplq);
  rgph=plq_clean(rgph);
  b = plq_isEqual(rplq, rgph);  
assert(b) ;
end
