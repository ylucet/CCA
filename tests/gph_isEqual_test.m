function tests = gph_isEqual_test()
tests = functiontests(localfunctions);
end



function b = test1(testCase)
  %domain is split
  p1=[inf 1 0 0];g1=gph_plq(p1);
  p2=[0 1 0 0;inf 1 0 0];g2=gph_plq(p2);
  b=gph_isEqual(g1,g2);
  %small values
  eps=1e-9;
  p2=[inf 1+eps eps -eps];g2=gph_plq(p2);
  b=b & gph_isEqual(g1,g2);
  %small values + split partitions
  p2=[-eps 1 0 eps;eps 1-eps -eps/10 0;inf 1 -eps eps/1000];
  g2=gph_plq(p2);
  b=b & gph_isEqual(g1,g2);
assert(b) 
end

function b = testIndicator(testCase)
  p = [2,0,0,1];
  g = gph_plq(p);
  ge = [2 2;-1 1;1 1];
  b = gph_isEqual(g,ge);
assert(b) 
end

function b = testFullDomain(testCase)
  p = [2,0,0,1];
  g = gph_plq(p);
  ge = [2 2;-1 1;1 1];
  b = gph_isEqual(g,ge);
assert(b) 
end

function b= test2(testCase)
  p = [-1 -1 1 1; -1 0 0 1;inf 0 0 inf];  
  g = gph_plq(p);
  b = gph_isEqual(g,g);  
assert(b) 
end