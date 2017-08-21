function tests = plq_ll_test()
tests = functiontests(localfunctions);
end



function [b] = test1(testCase)
	b = false;
    lambda=0.7;mu=0.4;
	fctn = [-1,0,-1,-1;0,0,1,1;1,0,-1,1;inf,0,1,-1];
	result = plq_ll(fctn,lambda,mu);
	desired = [-1.3 0. -1. -1.15; -0.7 1.6666667 3.3333333 1.6666667; 
    -0.4 0. 1. 0.85; 0.4 -1.25 0. 0.65; 0.7 0. -1. 0.85; 1.3 1.6666667 -3.3333333 1.6666667;
   inf 0. 1. -1.15];
	b = plq_isEqual(result,desired);
assert(b) 
end

function [b] = runTestFile(testCase)
	b = true;
	b = checkForFail(testWrapper(test1,'test1'), b);
assert(b) 
end
