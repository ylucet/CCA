function tests = plq_clrDuplicateRows_test()
tests = functiontests(localfunctions);
end



function [b] = testDuplicatePoints(testCase)
	plqDirty=[0,1,0,0;0,2,0,0;1,2,3,4;inf,3,0,0];
	plqClean=plq_clean(plqDirty);
	plqdesired = [0,1,0,0;1,2,3,4;inf,3,0,0];
	b = all(plqdesired==plqClean);
assert(all(all(b))); 
end

function [b] = testDuplicateRows(testCase)
	plqDirty=[0,1,0,0;0,1,0,0;1,2,3,4;inf,3,0,0];
	plqClean=plq_clean(plqDirty);
	plqdesired = [0,1,0,0;1,2,3,4;inf,3,0,0];
	b = all(plqdesired==plqClean);
assert(all(all(b))); 
end

function [b] = testDuplicatePoints2(testCase)
	plqDirty=[-1,1,2,3;0,1,0,0;0,2,0,0;1,2,3,4;2,4,5,6;inf,3,0,0];
	plqClean=plq_clean(plqDirty);
	plqdesired = [-1,1,2,3;0,1,0,0;1,2,3,4;2,4,5,6;inf,3,0,0];
	b = all(plqdesired==plqClean);
assert(all(all(b))); 
end

function [b] = testDuplicateRows2(testCase)
	plqDirty=[-1,1,2,3;0,1,0,0;0,1,0,0;1,2,3,4;2,3,4,5;inf,3,0,0];
	plqClean=plq_clean(plqDirty);
	plqdesired = [-1,1,2,3;0,1,0,0;1,2,3,4;2,3,4,5;inf,3,0,0];
	b = all(plqdesired==plqClean);
assert(all(all(b))); 
end

function [b] = testDuplicateEnd(testCase)
	plqDirty=[-1,1,2,3;0,1,0,0;0,1,0,0;0,2,0,0;1,2,3,4;2,3,4,5;inf,3,4,5];
	plqClean=plq_clean(plqDirty);
	plqdesired = [-1,1,2,3;0,1,0,0;1,2,3,4;inf,3,4,5];
	b = all(plqdesired==plqClean);
assert(all(all(b))); 
end

function [b] = testQuadratic(testCase)
  x=linspace(-2,2)';
  x(end)=inf;
  plqDirty=[x,ones(size(x)),zeros(size(x)),zeros(size(x))];
  plqClean=plq_clean(plqDirty);
  plqdesired = [inf,1,0,0];
  b = all(plqdesired==plqClean);
  assert(all(all(b))); 
end

function [b] = testLinear(testCase)
x=linspace(-2,2)';
  function y=f(x), if abs(x)<=1 y=0; else y=abs(x)-1;end;end
  function y=df(x), if abs(x)<=1 y=0; else y=sign(x);end;end
	plqDirty=plq_build(x,@f,@df,true);
	plqClean=plq_clean(plqDirty);
	plqdesired = [0,0,-1,-1;inf,0,1,-1];
	b = all(plqdesired==plqClean);
    assert(all(all(b))); 
end


function [b] = testDuplicateFunctions(testCase)
	b = false;
	plqfstarDirty = [0,0,0,0; 1,1,1,1; 2,1,1,1; 3,2,2,2];
	result = plq_clean(plqfstarDirty);
	desired = [0, 0, 0, 0;2,1,1,1;3,2,2,2];         
	b = all(result==desired);
assert(all(all(b))); 
end

function [b] = testDuplicateDomains(testCase)
	b = false;
	plqfstarDirty = [0,0,0,0; 1,1,1,1; 1,2,3,4; 3,2,2,2];
	result = plq_clean(plqfstarDirty);
	desired = [0, 0, 0, 0;1,1,1,1;3,2,2,2];         
	b = all(result==desired);
assert(all(all(b))); 
end

function [b] = testDuplicateDomsAndFns(testCase)
	b = false;
	plqfstarDirty = [0,0,0,0; 1,13,13,13; 1,7,7,7; 2,7,7,7; 3,2,2,2];
	result = plq_clean(plqfstarDirty);
	desired = [0,0,0,0;1,13,13,13;2,7,7,7;3,2,2,2];         
	b = all(result==desired);
assert(all(all(b))); 
end

function [b] = testRound2Zero(testCase)
	b = false;
	plqfstarDirty = [1E-15,0,0,0; 1,13,1E-14,13; 2,1E-12,7,7; 3,2,2,1E-10];
	result = plq_clean(plqfstarDirty);
	desired = [0,0,0,0;1,13,0,13;2,0,7,7;3,2,2,0];         
	b = all(result==desired);
assert(all(all(b))); 
end