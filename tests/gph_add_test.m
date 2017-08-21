function tests = gph_add_test()
tests = functiontests(localfunctions);
end

% Unit test file for gph_add

% The codes for the gph model are as follows:
% - I represents a point indicator
% - L represents a linear plq region (flat line in the gph)
% - Q represents a quadratic plq region (non-flat line in the gph)
% - B represents bounded on a specific side


function b = testI_I_same(testCase)
	% Add two point indicators with different x values.

	b = false;
	gph1 = [2 2; -1 1; 3 3];    % f(2) = 3
	gph2 = [2 2; -1 1; 5 5];    % f(2) = 5

	X = [1; 2; 3; 5; 8; 10];
	expected = [inf; 8; inf; inf; inf; inf];
	gph = gph_add(gph1, gph2);
	actual = gph_eval(gph, X);
	b = all(expected == actual);
    assert(all(all(b))) 
end

function b = testI_I_diff(testCase)
	% Add two point indicators with different x values.

	b = false;
	gph1 = [2 2; -1 1; 3 3];    % f(2) = 3
	gph2 = [5 5; -1 1; 8 8];    % f(5) = 8

	X = [1; 2; 3; 5; 8; 10];
	expected = X + inf;
	gph = gph_add(gph1, gph2);
	actual = gph_eval(gph, X);
	b = all(expected == actual);
    assert(all(all(b))) 
end

function b = testI_LL(testCase)
	% Add a point indicator to a linear function, and assert that
        % the result is another point indicator.

	b = false;
	gph1 = [-1 -1; -1 1; 2 2];
	gph2 = [-1 0 0 1; -1 -1 1 1; 1 0 0 1];
	gph = gph_add(gph1, gph2);
	b = gph(1,1)==-1 & gph(1,2)==-1 & gph(3,1)==3 & gph(3,2)==3;
    assert(all(all(b))) 
end

function b = testL_L_sameX(testCase)
	% Add two single-region linear functions, defined with different X
        % values.

	eps = 1e-10;
	b = false;
	gph1 = [-5 -4; 0 0; 2 2];    % f(x) = 2
	gph2 = [-5 -4; 2 2; -7 -5];    % f(x) = 2*x + 3

	X = (-1.5:0.5:1.5)';
	expected = 2*X + 5;
	gph = gph_add(gph1, gph2);
	actual = gph_eval(gph, X);
	b = all(abs(expected - actual) < eps);    assert(all(all(b))) 
end

function b = testL_L_diffX(testCase)
	% Add two single-region linear functions, defined with identical x
        % values.

	eps = 1e-10;
	b = false;
	gph1 = [-1 1; 0 0; 2 2];    % f(x) = -5*X - 10
	gph2 = [0 1; 2 2; 3 5];    % f(x) = 2*X + 3

	X = (-1.5:0.5:1.5)';
	expected = 2*X + 5;
	gph = gph_add(gph1, gph2);
	actual = gph_eval(gph, X);
	b = all(abs(expected - actual) < eps);
    assert(all(all(b))) 
end

function b = testQ_LQ_oneSameX(testCase)
	% Add a single-region quadratic function to a two-region function,
	% where an x value in the first lines up with an x value in the second.

	eps = 1e-10;
	b = false;
	gph1 = [0 1; 0 2; 0 1];    % f(x) = x^2
	gph2 = gph_plq([0,0,-1,0; inf,1/2,0,0]);

	X = (-2:0.5:2)';
	expected = [6; 3.75; 2; 0.75; 0; 0.375; 1.5; 3.375; 6];
	gph = gph_add(gph1, gph2);
	actual = gph_eval(gph, X);
	b = all(abs(expected - actual) < eps);
    assert(all(all(b))) 
end

function b = testQ_LQ_allDiffX(testCase)
	% Add a single-region quadratic function to a two-region function,
	% where NO x value in the first lines up with an x value in the second.

	eps = 1e-10;
	b = false;
	gph1 = [0 1; 0 2; 0 1];    % f(x) = x^2
	gph2 = gph_plq([5,0,-1,5; inf,1/2,-5,25/2]);

	X = (-2:0.5:7)';
	expected = [11; 8.75; 7; 5.75; 5; 4.75; 5; 5.75; 7; 8.75; 11; ...
		    13.75; 17; 20.75; 25; 30.375; 36.5; 43.375; 51];
	gph = gph_add(gph1, gph2);
	actual = gph_eval(gph, X);
	b = all(abs(expected - actual) < eps);
    assert(all(all(b))) 
end

function b = testQ_BL(testCase)
	% Add a single-region quadratic function to a lower-bounded
        % single-linear-region function.

	eps = 1e-10;
	b = false;
	gph1 = [1 2; 2 4; 1 4];    % f(x) = x^2
	gph2 = gph_plq([0,0,0,inf; inf,0,1,0]);    % f(x) = x, x > 0

	X = (-1:0.5:2)';
	expected = [inf; inf; 0; 0.75; 2; 3.75; 6];
	gph = gph_add(gph1, gph2);
	actual = gph_eval(gph, X);
	b = all(expected == actual | abs(expected - actual) < eps);
    assert(all(all(b))) 
end

function b = testBLB_BLB(testCase)
	% Add two bounded linear functions with different, overlapping,
	% domains.

	eps = 1e-10;
	b = false;
	% f(x) = 2*x, for -1 <= x <= 1.
	gph1 = [-1 -1 1 1; 1 2 2 3; inf -2 2 inf];
	% g(x) = 3, for 0 <= x <= 2.
	gph2 = [0 0 2 2; -1 0 0 1; inf 3 3 inf];

	X = (-1.5:0.5:2.5)';
	expected = [inf inf inf 3 4 5 inf inf inf]';
	gph = gph_add(gph1, gph2);
	actual = gph_eval(gph, X);
	b = all(expected == actual | abs(expected - actual) < eps);
    assert(all(all(b))) 
end

function b = testLL_LL(testCase)
	% Add two unbounded linear functions with same domain breaks.
	eps = 1e-10;
	b = false;
	gph1 = gph_plq([0,0,0,0; inf,0,2,0]);
	gph2 = gph_plq([0,0,-1,0; inf,0,1,0]);
	X = (-1.5:0.5:1.5)';
	expected = [1.5 1 0.5 0 1.5 3 4.5]';
	gph = gph_add(gph1, gph2);
	actual = gph_eval(gph, X);
	b = all(expected == actual | abs(expected - actual) < eps);
    assert(all(all(b))) 
end

function b = testLL_LL_2(testCase)
	% Add two unbounded linear functions with different domain breaks.
	eps = 1e-10;
	b = false;
	gph1 = gph_plq([0,0,0,0; inf,0,2,0]);
	gph2 = gph_plq([2,0,-1,2; inf,0,1,-2]);
	X = (-1.5:0.5:3.5)';
	expected = [3.5, 3, 2.5, 2, 2.5, 3, 3.5, 4, 5.5, 7, 8.5]';
	gph = gph_add(gph1, gph2);
	actual = gph_eval(gph, X);
	b = all(expected == actual | abs(expected - actual) < eps);
    assert(all(all(b))) 
end

function b = testQLQ_BLB(testCase)
	% Add an unbounded quadratic-linear-quadratic function to a bounded
        % linear function defined only over two of the first function's regions.
	eps = 1e-10;
	b = false;
	gph1 = gph_plq([-1,1,2,1; 1,0,0,0; inf,1,-2,1]);
	gph2 = gph_plq([0,0,0,inf; 2,0,1,0; inf,0,0,inf]);
	X = (-2:0.5:3)';
	expected = [inf; inf; inf; inf; 0; 0.5; 1; 1.75; 3; inf; inf];
	gph = gph_add(gph1, gph2);
	actual = gph_eval(gph, X);
	b = all(expected == actual | abs(expected - actual) < eps);
    assert(all(all(b))) 
end

