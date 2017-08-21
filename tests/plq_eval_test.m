function tests = plq_eval_test()
tests = functiontests(localfunctions);
end
% Test-script for plq_eval (Yves Lucet - 2006-06-21)
%

% unit tests ==========================================================
function [b] = testXinsidex(testCase)
	X=[1;2;4;5;7;8;9];
	plqf=[3,0.5,0,0;6,0,0,0;inf,0,1,0];
	[y,k] = plq_eval(plqf,X);
	
	b = isequal(k, [1,2,3;1,3,5;2,4,7]);
	b = isequal(y, [0.5;2;0;0;7;8;9]) & b;
assert(b);
end

function [b] = testXemptybeforex(testCase)
	X=[4;5;7;8;9];
	plqf=[3,0.5,0,0;6,0,0,0;inf,0,1,0];
	[y,k] = plq_eval(plqf,X);
	b = isequal(k, [2,3; 1,3;2,5]);
	b = isequal(y, [0;0;7;8;9]) & b;
assert(b) 
end

function [b] = testXallbeforex(testCase)
	X=[4;5;7;8;9];
	plqf=[10,0.5,0,0;15,0,0,0;inf,0,1,0];
	[y,k] = plq_eval(plqf,X);
	b = isequal(k, [1;1;5]);
	b = isequal(y, [8;12.5;24.5;32;40.5]) & b;
assert(b) 
end

function [b] = testXalllastx(testCase)
	X=[4;5;7;8;9];
	plqf=[-2,0.5,0,0;1,0,0,0;inf,0,1,0];
	[y,k] = plq_eval(plqf,X);
	b = isequal(k, [3;1;5]);
	b = b & isequal(y, [4;5;7;8;9]);
assert(b) 
end

function [b] = testIndicator(testCase)
	X=(-5:5)';
	plqf=[0,0,0,1];
	y = plq_eval(plqf,X);
	yy=inf*ones(size(X));
	yy(6)=1;
	b = isequal(y, yy);
    assert(b) 
end
