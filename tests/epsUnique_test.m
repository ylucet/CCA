function tests = epsUnique_test()
tests = functiontests(localfunctions);
end



function [b] = test1(testCase)
  X=[1;1;2];eps=1E-6;
  [Xu,ku]=epsUnique(X,eps);
  b=isequal(Xu,[1;2]) & isequal(ku,[1;3]);
assert(b) 
end

function [b] = test2(testCase)
  eps=1E-6;
  X=[1;1;1;1;1+eps/10;2];
  [Xu,ku]=epsUnique(X,eps);
  b=isequal(Xu,[1;2]) & isequal(ku,[1;6]);
assert(b) 
end

function [b] = test3(testCase)
  eps=1E-6;
  X=linspace(0,eps,4)';
  [Xu,ku]=epsUnique(X,eps,true);
  b=isequal(Xu,[0;eps]) & isequal(ku,[1;4]);
assert(b) 
end

function [b] = runTestFile(testCase)
  b = true;
  b = checkForFail(testWrapper(test1,'test1'), b);    
  b = checkForFail(testWrapper(test2,'test2'), b);    
  b = checkForFail(testWrapper(test3,'test3'), b);    
assert(b) 
end
