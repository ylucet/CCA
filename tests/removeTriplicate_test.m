function tests = removeTriplicate_test()
tests = functiontests(localfunctions);
end



function [b] = test1(testCase)
  M=[1 2 2 3 3 3 4 4 4 4];
  [N,k]=removeTriplicate(M,1E-6);
  b=all(N==[1 2 2 3 3 4 4]) & all(k==[1 2 3 4 6 7 10]);
assert(b) 
end

function [b] = test2(testCase)
  M=[1 2 2 3 3 3 4 4 4 4 1 1];
  [N,k]=removeTriplicate(M,1E-6);
  b=all(N==[1 2 2 3 3 4 4 1 1]) & all(k==[1 2 3 4 6 7 10 11 12]);
assert(b) 
end


function [b] = runTestFile(testCase)
  b = true;
  b = checkForFail(testWrapper(test1,'test1'), b);    
  b = checkForFail(testWrapper(test2,'test2'), b);    
assert(b) 
end
