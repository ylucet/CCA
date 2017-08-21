function tests = gph_check_test()
tests = functiontests(localfunctions);
end



function [b] = testBoundedDomain(testCase)
  f=[-1 -1 1 1;-1 0 0 1;inf 0 0 inf];
  b=gph_check(f);
assert(b) 
end

function [b] = testXNondecreasing(testCase)
  f=[-1 -2 1 1;-1 0 0 1;0 0 0 0];
  b= ~gph_check(f);
assert(b) 
end

function [b] = testSNondecreasing(testCase)
  f=[-1 0 1 1;-1 0 0 -1;0 0 0 0];
  b= ~gph_check(f);
assert(b) 
end

function [b] = testN(testCase)
  f=[1;0;0];
  b=~gph_check(f);%n==1
  f=[-1 -2 1 1;-1 0 0 1];
  b=b & ~gph_check(f);%2xn
assert(b) 
end

function [b] = testFullDomain(testCase)
  p=[inf,1,0,0];f=gph_plq(p);
  b=gph_check(f);
assert(b) 
end

function [b] = testIndicatorSingleton(testCase)
  p=[1,0,0,2];f=gph_plq(p);
  b=gph_check(f);
assert(b) 
end

function [b] = testCont(testCase)
  b = false;
  f = [  -1 -1  0 0 1    1; ...
         -2 -1 -1 0 2    3; ...
       inf  1  0 0 1 inf];
  b = gph_check(f);
assert(b) 
end

function [b] = testDiscont1(testCase)
  b = false;
  f = [  -1 -1  0 0 1    1; ...
         -2 -1 -1 0 2    3; ...
       inf  1  1 1 2 inf];
  b = ~gph_check(f);
assert(b) 
end

function [b] = testDiscont2(testCase)
  b = false;
  f = [  -1 -1  0 0 1    1; ...
         -2 -1 -1 0 2    3; ...
       inf  1  0 1 1 inf];
  b = ~gph_check(f);
assert(b) 
end

function [b] = testDiscont3(testCase)
  b = false;
  f = [  -1 -1  0 0 1    1; ...
         -2 -1 -1 0 2    3; ...
       inf  1  1 0 1 inf];
  b = ~gph_check(f);
assert(b) 
end

function [b] = testDiscontL(testCase)
  % Test discontinuity in the first region.
  b = false;
  f = [-1  0 0 1; ...
       -1 -1 1 1; ...
        2  0 0 1];
  b = ~gph_check(f);
assert(b) 
end

function [b] = testDiscontR(testCase)
  % Test discontinuity in the first region.
  b = false;
  f = [-1  0 0 1; ...
       -1 -1 1 1; ...
        1  0 0 2];
  b = ~gph_check(f);
assert(b) 
end