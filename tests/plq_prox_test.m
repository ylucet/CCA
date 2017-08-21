function tests = gph_me_test()
tests = functiontests(localfunctions);
end


%perform all tests
%p: input plq function
%lambda: input real number lambda >0
function b = prim(p, lambda)
  m=plq_me(p,lambda);
  r=plq_prox(p,lambda);%monotone but nonconvex
  %since there is no plq_compose function
  %we numerically evaluate the moreau envelope
  %computed directly and through the proximal mapping
  dx=linspace(-10,10)';
  dy=plq_eval(r,dx);
  dp=plq_eval(p,dy);
  dz=dp+(dx-dy).^2/(2*lambda);
  
  dm=plq_eval(m,dx);
  b=all((dm-dz)+1);
end

function b = testAbs(testCase)
  p=[0 0 -1 0; inf 0 1 0];lambda =2;
  b = prim(p,lambda);
assert(all(all(b))) 
end

function b = testPLQ0(testCase)
	p=[inf 1 0 0];lambda=3;
    b = prim(p,lambda);
assert(all(all(b))) 
end

function b = testPLQ1(testCase)
  % A PLQ function:
  %     x<-1: y=(x+1)^2
  %   -1<x<1: y=0
  %      1<x: y=(x-1)^2
  p=[-1 1 2 1;1 0 0 0;inf 1 -2 1];
  lambda=3;
  b = prim(p,lambda);
assert(all(all(b))) 
end

function b = testPL(testCase)
	% A piecewise linear function:
	%     x<0: y=-x
	%   0<x<1: y=0
	%     1<x: y=x-1
	p = [0 0 -1 0;1 0 0 0;inf 0 1 -1];
  lambda=20;
  b = prim(p,lambda);
assert(all(all(b))) 
end

function b = testPLQ2(testCase)
	% A PLQ function:
	%   x in [-1,1]: 0
	%     otherwise: x^2 - 1
  p=[-1 1 0 -1;1 0 0 0;inf 1 0 -1];
  lambda=3/4;
  b = prim(p,lambda);

assert(all(all(b))) 
end

function b = testQuadratic(testCase)
  p=[inf,1,0,0];
  lambda=1/10;
  b = prim(p,lambda);
assert(all(all(b))) 
end

function b = testLinear(testCase)
  p=[inf,0,1,0];
  lambda=1/3;
  b = prim(p,lambda);
assert(all(all(b))) 
end

function b = testIndicatorSingleton(testCase)
  p=[1,0,0,2];
  lambda=30.5;
  b = prim(p,lambda);
assert(all(all(b))) 
end

function b = testInd(testCase)
  p=[-1 0 0 inf;1 0 0 0 ;inf 0 0 inf];  lambda=10;
  b = prim(p,lambda);
assert(all(all(b))) 
end

function b = runTestFile(testCase)
	b = true;
	b = checkForFail(testWrapper(testPLQ0,'testPLQ0'), b);	
	b = checkForFail(testWrapper(testAbs,'testAbs'), b);
	b = checkForFail(testWrapper(testPL,'testPL'), b);
	b = checkForFail(testWrapper(testPLQ1,'testPLQ1'), b);
	b = checkForFail(testWrapper(testPLQ2,'testPLQ2'), b);
	b = checkForFail(testWrapper(testQuadratic,'testQuadratic'), b);
	b = checkForFail(testWrapper(testLinear,'testLinear'), b);
	b = checkForFail(testWrapper(testIndicatorSingleton,'testIndicatorSingleton'), b);	
	b = checkForFail(testWrapper(testInd,'testInd'), b);		
assert(all(all(b))) 
end
