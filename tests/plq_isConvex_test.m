function tests = plq_isConvex_test()
tests = functiontests(localfunctions);
end


function b = testAbs(testCase)
	%abs function
  p = [0,0,-1,0;inf,0,1,0];  
  b = plq_isConvex(p);
assert(b) 
end

function b = testQuartic(testCase)
  function y=f(x), y=x.^4;end
  function dy=df(x), dy=4*x.^3;end
  x=linspace(-2,2,4)';
  
  p=plq_build(x,@f,@df,true,false,'soqs','bounded');
  b = plq_isConvex(p);
assert(b) 
end
 

function [b] = testInd(testCase)
	% The function I_[-1,1].
  p = [-1,0,0,inf; 1,0,0,0; inf,0,0,inf];
  b = plq_isConvex(p);
assert(b) 
end

function [b] = testPL(testCase)
  p = [0,0,-1,0; 1,0,0,0; inf,0,1,-1];
  b = plq_isConvex(p);
  assert(b) 
end

function [b] = testPLQ1(testCase)
	b = false;
	% A PLQ function:
	%     x<-1: y=(x+1)^2
	%   -1<x<1: y=0
	%      1<x: y=(x-1)^2
  p = [-1,1,2,1; 1,0,0,0; inf,1,-2,1];
  b = plq_isConvex(p);
assert(b) 
end

function b = testPLQ2(testCase)
	% A PLQ function:
	%   x in [-1,1]: 0
	%     otherwise: x^2 - 1
  p = [-1,1,0,-1; 1,0,0,0; inf,1,0,-1];
  b = plq_isConvex(p);
assert(b) 
end

function b = testFullDomain(testCase)
  p = [inf,1,0,0];
  b = plq_isConvex(p);
assert(b) 
end

function b = testIndicator(testCase)
  p = [2,0,0,1];
  b = plq_isConvex(p);
assert(b) 
end