function tests = gph_eval_test()
tests = functiontests(localfunctions);
end



function [b] = testIndicator(testCase)
	eps = 1e-10;
	gph = [-1 -1; -1 1; -3 -3];%I_{-1)-3
	X = [-3; -2; -1; 0; 1; 2];
	Z = gph_eval(gph, X);
	expected = [inf; inf; -3; inf; inf; inf];
	b = all(expected == Z | abs(expected - Z) < eps);
assert(b) 
end

function [b] = testSingleRegion(testCase)
	eps = 1e-10;
	b = false;
	% f(x) = -3*X^2 + 5   (subdifferential: -6*X)
	gph = [-3 -1; 18 6; -22 2];
	X = (-4:0.5:1)';
	Z = gph_eval(gph, X);

	expected = -3*X.^2 + 5;
	b = all(abs(expected - Z) < eps);
assert(b) 
end

function [b] = testAbs(testCase)
	eps = 1e-10;
	b = false;
	%abs function
	gph = [-1, 0, 0, 1; ...
	       -1, -1, 1, 1; ...
	       1, 0, 0, 1];
	X = [-100; -5; -1; -0.5; 0; 0.1; 0.8; 1; 1.01; 12];
	Z = gph_eval(gph, X);

	expected = abs(X);
	b = all(abs(expected - Z) < eps);
assert(b) 
end

function [b] = testL_bounded(testCase)
	gph = [-1, -1, 1, 1; ...
	       -1, 0, 0, 1; ...
	       inf, 0, 0, inf];%I_[-1,1].
	X = [-5; -1.01; -1; -1;-1;-0.8; -0.2; 0; 0.5; 0.999; 1; 1.001; 5; 100];
	Z = gph_eval(gph, X);
	expected = [inf; inf; 0; 0; 0; 0; 0; 0; 0; 0; 0; inf; inf; inf];
	b = all(expected == Z);
assert(b) 
end

function [b] = testPL(testCase)
	eps = 1e-10;
	% A "	
    gph = [-1, 0, 0, 1, 1, 2; ...
	       -1, -1, 0, 0, 1, 1; ...
	       1, 0, 0, 0, 0, 1];
	X = [-6; -1; -0.5; 0; 0.5; 1; 1.5; 2; 4; 20];
	Z = gph_eval(gph, X);

	expected = [6; 1; 0.5; 0; 0; 0; 0.5; 1; 3; 19];
	b = all(abs(expected - Z) < eps);
assert(b) 
end

function [b] = testPLQ1(testCase)
	eps = 1e-10;
	b = false;
	% A PLQ function:
	%     x<-1: y=(x+1)^2
	%   -1<x<1: y=0
	%      1<x: y=(x-1)^2
	gph = [-2, -1, 1, 2; ...
	       -2,  0, 0, 2; ...
	       1, 0, 0, 1];
	X = [-6; -4; -2.5; -1.75; -1; -0.5; 0; 0.75; 1; 1.5; 2; 2.5; 3; 5; 11];
	Z = gph_eval(gph, X);

	expected = [25; 9; 2.25; 0.5625; 0; 0; 0; 0; 0; 0.25; 1; 2.25; 4; 16; 100];
	b = all(abs(expected - Z) < eps);
assert(b) 
end

function [b] = testPLQ2(testCase)
	eps = 1e-10;
	b = false;
	% A PLQ function:
	%   x in [-1,1]: 0
	%     otherwise: x^2 - 1
	gph = [-2, -1, -1, 1, 1, 2; ...
	       -4, -2, 0, 0, 2, 4; ...
	       3, 0, 0, 0, 0, 3];
	X = [-9; -5; -2; -1.01; -1; -0.25; 0.1; 0.99; 1; 1.5; 2; 2.5; 3; 7];
	Z = gph_eval(gph, X);

	expected = [80; 24; 3; 0.0201; 0; 0; 0; 0; 0; 1.25; 3; 5.25; 8; 48];
	b = all(abs(expected - Z) < eps);
assert(b) 
end

function [b] = testEmpty(testCase)
	gph = [-1, 0, 0, 1;-1, -1, 1, 1; 1, 0, 0, 1];%abs
	X = [];
	Z = gph_eval(gph, X);
	expected = [];
	b = all(expected == Z);
assert(b) 
end

function b=test1(testCase)
  %evaluate on G(1,:) only
  G = [-1, 0, 0, 1;-1, -1, 1, 1; 1, 0, 0, 1];%abs
  x=[-1;0;0;1];
  y=gph_eval(G,x);
  b = isequal(y,[1;0;0;1]);
assert(b) 
end

 
function b = runTestFile(testCase)
	b = true;
	b = checkForFail(testWrapper(testIndicator,'testIndicator'), b);%error
	b = checkForFail(testWrapper(testSingleRegion,'testSingleRegion'), b);
	b = checkForFail(testWrapper(testAbs,'testAbs'), b);
	b = checkForFail(testWrapper(testL_bounded,'testL_bounded'), b);%fail
	b = checkForFail(testWrapper(testPL,'testPL'), b);
	b = checkForFail(testWrapper(testPLQ1,'testPLQ1'), b);
	b = checkForFail(testWrapper(testPLQ2,'testPLQ2'), b);
	b = checkForFail(testWrapper(testEmpty,'testEmpty'), b);
	b = checkForFail(testWrapper(test1,'test1'), b);	%fail
assert(b) 
end
