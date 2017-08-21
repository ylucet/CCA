function tests = plq_me_test()
tests = functiontests(localfunctions);
end



function [b] = testMELineWrapper(testCase)
	b = false;
	lambda=1;
	fctn = [inf,0,1,1];
	result = plq_me(fctn,lambda);
	desired = [inf, 0, 1, 1/2];    
	b = all(result==desired);
assert(b); 
end

function [b] = testMEQuadraticWrapper(testCase)
	b = false;
	lambda=1;
	fctn = [inf,1/2,0,0];
	result = plq_me(fctn,lambda);
	desired = [inf, 1/4, 0, 0];         
	b = all(result==desired);
assert(b);
end

function [b] = testMEIndicatorWrapper(testCase)
	b = false;
	lambda = 1;
	plqf = [5,0,0,1];
	result = plq_me(plqf,lambda);
	desired = [inf,0.5,- 5, 13.5];
	b = all(result==desired);
assert(b); 
end

function [b] = testMEnonconvex(testCase)
	b = false;
	lambda = 1;plqf=[-1,0,-1,-1;0,0,1,1;1,0,-1,1;inf,0,1,-1];
	result = plq_me(plqf,lambda,false);
	desired = [-2,0,-1,-1.5;0,0.5,1,0.5;2,0.5,-1,0.5;inf,0,1,-1.5];
	b = (result==desired);
assert(all(all(b))); 
end

function [b] = testMaxScale1(testCase)
  b = false;
  f = [0,-1,0,0;inf,-2,0,0];
  desired = -1/2/(-2);
  result = plq_me_max_scale(f);
  b = isequal(desired, result);
assert(b); 
end

function [b] = testMaxScale2(testCase)
  b = false;
  f = [0,1,0,0;inf,0,1,0];
  desired = inf;
  result = plq_me_max_scale(f);
  b = isequal(desired, result);
assert(b); 
end

function [b] = testMaxScale3(testCase)
  b = false;
  f1 = [0,-1,0,0;inf,-2,0,0];
  f2 = [1,0,1,0;2,0,-1,2;inf,-3,0,0];
  m1 = plq_me_max_scale(f1);
  m2 = plq_me_max_scale(f2);
  m = plq_me_max_scale(f1, f2);
  b = (isequal(m, 1/6) & m == min(m1, m2));
assert(b); 
end


