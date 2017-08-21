function tests = plq_scalar_test()
tests = functiontests(localfunctions);
end
% Unit test file for gph_scalar




function [b] = testAbs(testCase)
    p =[0 0 -1 0; inf 0 1 0];%abs function
    q=plq_scalar(p,3);
    qq=[0 0 -3 0; inf 0 3 0];
	b = plq_isEqual(q,qq);

    q=plq_scalar(p,0);
    qq=[inf 0 0 0];
	b = b & plq_isEqual(q,qq);	

    q=plq_scalar(p,-2);
    qq=[0 0 2 0; inf 0 -2 0];
	b = b & plq_isEqual(q,qq);		
assert(b) 
end

function [b] = testInd(testCase)
	p=[-1 0 0 inf;1 0 0 0 ;inf 0 0 inf]; 
    q=plq_scalar(p,3);
    qq=p;
	b = plq_isEqual(q,qq);

    q=plq_scalar(p,0);
    qq=p;
	b = b & plq_isEqual(q,qq);	

    q=plq_scalar(p,-2);
    qq=[-1 0 0 -inf;1 0 0 0 ;inf 0 0 -inf];
	b = b & plq_isEqual(q,qq);		
assert(b) 
end

function [b] = testPL(testCase)
	% A piecewise linear function:
	%     x<0: y=-x
	%   0<x<1: y=0
	%     1<x: y=x-1
	G = [-1, 0, 0, 1, 1, 2; -1, -1, 0, 0, 1, 1; 1, 0, 0, 0, 0, 1];
	p=plq_gph(G);
    q=plq_scalar(p,3);
    qq=[0 0 -3 0;1 0 0 0;inf 0 3 -3];
	b = plq_isEqual(q,qq);

    q=plq_scalar(p,0);
    qq=[inf 0 0 0];
	b = b & plq_isEqual(q,qq);	

    q=plq_scalar(p,-2);
    qq=[0 0 2 0;1 0 0 0;inf 0 -2 2];
	b = b & plq_isEqual(q,qq);		
assert(b) 
end

function [b] = testPLQ1(testCase)
	b = false;
	% A PLQ function:
	%     x<-1: y=(x+1)^2
	%   -1<x<1: y=0
	%      1<x: y=(x-1)^2
	p=[-1 1 2 1;1 0 0 0;inf 1 -2 1];
    q=plq_scalar(p,3);
    qq=[-1 3 6 3;1 0 0 0;inf 3 -6 3];
	b = plq_isEqual(q,qq);

    q=plq_scalar(p,0);
    qq=[inf 0 0 0];
	b = b & plq_isEqual(q,qq);	

    q=plq_scalar(p,-2);
    qq=[-1 -2 -4 -2;1 0 0 0;inf -2 4 -2];
	b = b & plq_isEqual(q,qq);		
assert(b) 
end

function [b] = testPLQ2(testCase)
	b = false;
	% A PLQ function:
	%   x in [-1,1]: 0
	%     otherwise: x^2 - 1
	p=[-1 1 0 -1;1 0 0 0;inf 1 0 -1];
    q=plq_scalar(p,3);
    qq=[-1 3 0 -3;1 0 0 0;inf 3 0 -3];
	b = plq_isEqual(q,qq);

    q=plq_scalar(p,0);
    qq=[inf 0 0 0];
	b = b & plq_isEqual(q,qq);	

    q=plq_scalar(p,-2);
    qq=[-1 -2 0 2;1 0 0 0;inf -2 0 2];
	b = b & plq_isEqual(q,qq);		
assert(b) 
end

function [b] = testQuadratic(testCase)
  p=[inf,1,0,0];
    q=plq_scalar(p,3);
    qq=[inf,3,0,0];
	b = plq_isEqual(q,qq);

    q=plq_scalar(p,0);
    qq=[inf 0 0 0];
	b = b & plq_isEqual(q,qq);	

    q=plq_scalar(p,-2);
    qq=[inf,-2,0,0];
	b = b & plq_isEqual(q,qq);		
assert(b) 
end

function [b] = testLinear(testCase)
    p=[inf,0,1,0];
    q=plq_scalar(p,3);
    qq=[inf,0,3,0];
	b = plq_isEqual(q,qq);

    q=plq_scalar(p,0);
    qq=[inf 0 0 0];
	b = b & plq_isEqual(q,qq);	

    q=plq_scalar(p,-2);
    qq=[inf,0,-2,0];
	b = b & plq_isEqual(q,qq);		
assert(b) 
end

function [b] = testIndicatorSingleton(testCase)
  p=[1,0,0,2];
  q=plq_scalar(p,3);
  qq=[1,0,0,6];
  b = plq_isEqual(q,qq);

  q=plq_scalar(p,0);
  qq=[1 0 0 0];
  b = b & plq_isEqual(q,qq);	

  q=plq_scalar(p,-2);
  qq=[1,0,0,-4];
  b = b & plq_isEqual(q,qq);
  b = b & ~(q(1)==inf);
assert(b) 
end

function [b] = testIndMinus(testCase)
  p=[-1 0 0 inf;1 0 0 0 ;inf 0 0 inf];  p=plq_scalar(p,-1);	
  q=plq_scalar(p,3);
  qq=p;
  b = plq_isEqual(q,qq);

  q=plq_scalar(p,0);
  qq=p;
  b = b & plq_isEqual(q,qq);	

  q=plq_scalar(p,-2);
  qq=[-1 0 0 inf;1 0 0 0 ;inf 0 0 inf];
  b = b & plq_isEqual(q,qq);
assert(b) 
end

function [b] = runTestFile(testCase)
	b = true;
	b = checkForFail(testWrapper(testAbs,'testAbs'), b);
	b = checkForFail(testWrapper(testInd,'testInd'), b);
	b = checkForFail(testWrapper(testPL,'testPL'), b);
	b = checkForFail(testWrapper(testPLQ1,'testPLQ1'), b);
	b = checkForFail(testWrapper(testPLQ2,'testPLQ2'), b);
	b = checkForFail(testWrapper(testQuadratic,'testQuadratic'), b);
	b = checkForFail(testWrapper(testLinear,'testLinear'), b);
	b = checkForFail(testWrapper(testIndicatorSingleton,'testIndicatorSingleton'), b);	
b = checkForFail(testWrapper(testIndMinus,'testIndMinus'), b);		
assert(b) 
end
