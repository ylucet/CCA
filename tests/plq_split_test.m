


function tests = plq_split_test()
tests = functiontests(localfunctions);
end

%perform all tests by comparing with plq functions
function b = prim(p)
  P=gph_plq(p);
  q=plq_scalar(p,3);Q=gph_plq(q);
  QQ=gph_scalar(P,3);
  b = gph_isEqual(Q,QQ);

  q=plq_scalar(p,0);Q=gph_plq(q);
  QQ=gph_scalar(P,0);
  b = b & gph_isEqual(Q,QQ);
end

function [b] = testAbs(testCase)
    p =[0 0 -1 0; inf 0 1 0];%abs function
    b = prim(p);
    assert(b) 
end

function [b] = testInd(testCase)
  p=[-1 0 0 inf;1 0 0 0 ;inf 0 0 inf];
  b = prim(p);
assert(b) 
end

function [b] = testPL(testCase)
	% A piecewise linear function:
	%     x<0: y=-x
	%   0<x<1: y=0
	%     1<x: y=x-1
	G = [-1, 0, 0, 1, 1, 2; ...
	     -1, -1, 0, 0, 1, 1; ...
	     1, 0, 0, 0, 0, 1];
	p=plq_gph(G);
	b = prim(p);
assert(b) 
end

function [b] = testPLQ1(testCase)
	b = false;
	% A PLQ function:
	%     x<-1: y=(x+1)^2
	%   -1<x<1: y=0
	%      1<x: y=(x-1)^2
	p=[-1 1 2 1;1 0 0 0;inf 1 -2 1];
	b = prim(p);
assert(b) 
end

function [b] = testPLQ2(testCase)
	b = false;
	% A PLQ function:
	%   x in [-1,1]: 0
	%     otherwise: x^2 - 1
	p=[-1 1 0 -1;1 0 0 0;inf 1 0 -1];
    b = prim(p);
assert(b) 
end

function [b] = testQuadratic(testCase)
  p=[inf,1,0,0];
  b = prim(p);
assert(b) 
end

function [b] = testLinear(testCase)
    p=[inf,0,1,0];
    b = prim(p);		
assert(b) 
end

function [b] = testIndicatorSingleton(testCase)
  p=[1,0,0,2];
  b = prim(p);
assert(b) 
end