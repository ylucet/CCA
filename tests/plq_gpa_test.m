function tests = plq_gpa_test()
tests = functiontests(localfunctions);
end
% I = Indicator, E = Exponential, C = Conjugate, L = Linear, Q = Quadratic


function [b] = testAbs(testCase)
  p0=[0,0,-1,0;inf,0,1,0];p1=p0;
  p =plq_gpa(p0,p1,0.5,1);
  q = [-0.2 0 -1 -0.1;0.2 2.5 0 0;inf,0,1,-0.1];
  b = plq_isEqual(p,q);
assert(b) 
end

function [b] = testZero(testCase)
  p0=[inf,0,0,0];p1=p0;
  p =plq_gpa(p0,p1,0.5,1);
  q = [inf,0,0,0];
  b = plq_isEqual(p,q);
assert(b) 
end

function [b] = testX(testCase)
  p0=[inf,1,0,0];p1=p0;
  p =plq_gpa(p0,p1,0.5,1);
  q = [inf,0.714285714,0,0];
  b = plq_isEqual(p,q);  
assert(b) 
end

function [b] = testL2I(testCase)
  p0=[inf,0,0,0];p1=[0,0,0,0];
  p =plq_gpa(p0,p1,0.5,1);
  q = [inf,0.416666666666,0,0];
  b = plq_isEqual(p,q);    
assert(b) 
end

function [b] = testL2Q(testCase)
  p0=[inf,0,0,0];p1=[inf,0.5,0,0];
  p =plq_gpa(p0,p1,0.5,1);
  q = [inf,0.15625,0,0];
  b = plq_isEqual(p,q);    
assert(b) 
end

function [b] = runTestFile(testCase)
	b = true;
	b = checkForFail(testWrapper(testAbs, 'testAbs'), b);
	b = checkForFail(testWrapper(testZero, 'testZero'), b);
	b = checkForFail(testWrapper(testX, 'testX'), b);	
	b = checkForFail(testWrapper(testL2I, 'testL2I'), b);	
  b = checkForFail(testWrapper(testL2Q, 'testL2Q'), b);
assert(b) 
end
