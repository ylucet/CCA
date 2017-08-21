function tests = plq_check_test()
tests = functiontests(localfunctions);
end


function [b] = test1(testCase)
  p=[-1 0 0 inf;0 0 0 0; 1 0 0 1;inf 0 0 inf];%discontinuous
  b=~plq_check(p,2);
assert(b) 
end

function [b] = test2(testCase)
  p=[-1 0 0 inf;0 0 0 0; -0.5 0 0 0;inf 0 0 inf];%x nonincreasing
  b=~plq_check(p,1);
  b= b & plq_check(p,2);
assert(b) 
end

function [b] = test3(testCase)
  p=[0 0 -1 0;inf 0 1 0];%abs
  b=plq_check(p);
  assert(b) 
end
