function tests = plq_dom_test()
tests = functiontests(localfunctions);
end


function b = test1(testCase)
  b=true;
  %full domains
  p=[inf 1 0 0];I=plq_dom(p);
  b=b & isequal(I,[-inf,inf]);
  p=[0,0,-1,0;inf,0,1,0];I=plq_dom(p);
  b=b & isequal(I,[-inf,inf]);
  %left bounded
  p=[0,0,0,inf;1,0,0,0;inf,1,0,0];I=plq_dom(p);
  b=b & isequal(I,[0,inf]);
  p=[0,0,0,inf;inf,1,0,0];I=plq_dom(p);
  b=b & isequal(I,[0,inf]);
  %right bounded
  p=[0,0,0,2;1,0,0,0;inf,0,0,inf];I=plq_dom(p);
  b=b & isequal(I,[-inf,1]);
  %left & right bounded  
  p=[0,0,0,inf;1,0,0,0;inf,0,0,inf];I=plq_dom(p);
  b=b & isequal(I,[0,1]);
  %singleton  
  p=[0,0,0,1];I=plq_dom(p);
  b=b & isequal(I,[0,0]);
assert(b) 
end


function [b] = runTestFile(testCase)
	b = true;
	b = checkForFail(testWrapper(test1,'test1'), b);	
assert(b) 
end
