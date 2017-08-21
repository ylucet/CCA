function tests = gph_pa_helper()
tests = functiontests(localfunctions);
end
% I = Indicator, E = Exponential, C = Conjugate, L = Linear, Q = Quadratic


function b=helper(f1, f2, lambda)
  rplq = plq_pa(f1,f2,lambda);
  G1=gph_plq(f1);
  G2=gph_plq(f2);
  G = gph_pa(G1,G2,lambda);
  rgph = plq_gph(G);
  b = plq_isEqual(rplq, rgph);
end

function [b] = testL2Lpa(testCase)
  f1 = [inf, 0, 1, 0];
  f2 = [inf, 0, -1, 5]; 
  b = helper(f1,f2,0.5);
assert(all(all(b))); 
end

function [b] = testI2Ipa(testCase)
  f1 = [6,0,0,4];
  f2 = [5,0,0,1];
  b = helper(f1,f2,0.5);  
assert(all(all(b))); 
end

function b = testQ2Q(testCase)
	p0 = [inf,0.5,0,0];
	p1 = [inf,1,-2,1];
	b = helper(p0,p1,0.2);
assert(all(all(b))); 
end

function [b] = testAbs2zero1a(testCase)
	f1 = [0,0,0,0];
	f2 = [0,0,-1,0;inf,0,1,0];
	b = helper(f2,f1,0.5);
assert(all(all(b))); 
end

function [b] = testAbs2zero1b(testCase)
	f1 = [0,0,0,0];
	f2 = [0,0,-1,0;inf,0,1,0];
	b = helper(f1,f2,0.5);
assert(all(all(b))); 
end

function b = testPLQ2PLQ(testCase)
  x=linspace(-2,2,4)';
  function y=f0(x),y=x.^4;end
  function y=df0(x),y=4*x.^3;end
  p0 = plq_build(x,@f0,@df0,false,false,'soqs','bounded');
  p1 = [inf,1,-2,1];
  b = helper(p1,p0,0.5);
  b = helper(p0,p1,0.5);
assert(all(all(b))); 
end

function [b] = testAbs2zero2a(testCase)
	f0 = [inf,0,0,0];
	f1 = [0,0,-1,0;inf,0,1,0];
	b = helper(f1,f0,0.5);
assert(all(all(b))); 
end

function [b] = testAbs2zero2b(testCase)
	f0 = [inf,0,0,0];
	f1 = [0,0,-1,0;inf,0,1,0];
	b = helper(f0,f1,0.5);
assert(all(all(b))); 
end

function b = test1(testCase)
  function y=f0(x), y=x.^4;end
  function y=df0(x), y=4*x.^3;end
  domf0=[-inf,inf];
  function y=f1(x), y=exp(x);end
  function y=df1(x), y=exp(x);end
  domf1=[-inf,inf];
  x=linspace(-10,10,5);
  p0 = plq_build(x,@f0,@df0,false,false,'soqs','bounded');
  p1 = plq_build(x,@f1,@df1,false,false,'soqs','bounded');  

  b = helper(p0,p1,0.5);
  assert(all(all(b))); 
end

function b= test2(testCase)
  f1=[-2,0,0,inf;-1,0,0,0;inf,0,0,inf];
  f2=[1,0,0,inf;2,0,0,0;inf,0,0,inf];
  b = helper(f1,f2,0.5);
 assert(all(all(b))); 
end

function test_expected(testCase)
  f1 = [6,0,0,4];
  f2 = [5,0,0,1];
  G1=gph_plq(f1);G2=gph_plq(f2);
  G = gph_pa(G1,G2,0.5);
  expected = [5.5 5.5; -1.5 1.5; 2.625 2.625];
  b = isequal(expected, G);
  assert(all(all(b)));
end
