function tests = gph_me_test()
tests = functiontests(localfunctions);
end

% Unit test file for gph_me


%ME-Line Y=X+1
function [b] = testMELineWrapper(testCase)
	b = false;
	lambda = 1;
	gph = [0 1; 1 1; 1 2];    % f(x) = x + 1
	gphme = gph_me(gph, lambda);
	X = (-5:0.5:5)';
	result = gph_eval(gphme, X);
	desired = X + 1/2;    % e_f(x) = x + 1/2
	b = all(result == desired);
assert(all(all(b))); 
end

function [b] = testMEQuadraticWrapper(testCase)
	b = false;
	lambda=1;
	gph = [-1 1; -1 1; 0.5 0.5];    % f(x) = 1/2*x^2
	gphme = gph_me(gph, lambda);
	X = (-3:0.5:3)';
	result = gph_eval(gphme, X);
	desired = 1/4 * X.^2;
	b = all(result == desired);
assert(all(all(b))); 
end

function [b] = testMEIndicatorWrapper(testCase)
	b = false;
	lambda = 1;
	gph = [5 5; -1 1; 1 1];    % Ind. f(5) = 1
	gphme = gph_me(gph, lambda);
	X = (-3:0.5:3)';
	result = gph_eval(gphme, X);
	desired = 1/2*X.^2 - 5.*X + 13.5;
	b = all(result == desired);
assert(all(all(b))); 
end

function [b] = testUnbSmall0(testCase)
	eps = 1e-10;
	b = false;
	lambda = 1;
	plq = [0,0,-1,0; inf,0,1,0];%abs
	expected = plq_me(plq, lambda);
	gph = gph_plq(plq);
	gphme = gph_me(gph, lambda);
	actual = plq_gph(gphme);
	b = all(actual == expected | abs(actual - expected) < eps);

	%scf();
	%plq_plot(expected, actual);
	%gph_plot(gphme, gph_plq(expected));
assert(all(all(b))); 
end

function [b] = testUnbSmall1(testCase)
	eps = 1e-10;
	b = false;
	lambda = 1;
	plq = [0,0,-1,0; 1,0,0,0; inf,1,-2,1];
	expected = plq_me(plq, lambda);
	gph = gph_plq(plq);
	gphme = gph_me(gph, lambda);
	actual = plq_gph(gphme);
	b = all(actual == expected | abs(actual - expected) < eps);

	%scf();
	%plq_plot(expected, actual);
	%gph_plot(gphme, gph_plq(expected));
assert(all(all(b))); 
end

function [b] = testUnbBig(testCase)
	eps = 1e-10;
	b = false;
	lambda = 1;
	plq = [-2,0,-2,-2; -1,0,-1.5,-1; 0,0,-0.5,0; 1,0,0,0; 2,0,1,-1; inf,1,-2,1];
	expected = plq_me(plq, lambda);
	gph = gph_plq(plq);
	gphme = gph_me(gph, lambda);
	actual = plq_gph(gphme);
	b = all(actual == expected | abs(actual - expected) < eps);

	%scf();
	%plq_plot(expected, actual);
	%gph_plot(gphme, gph_plq(expected));
assert(all(all(b))); 
end

function [b] = testLowerBounded(testCase)
	eps = 1e-10;
	b = false;
	lambda = 2;
	% (x-5)^2+1 = x^2 - 10x + 25 + 1
	plq = [2,0,0,inf; 5,0,-1,6; inf,1,-10,26;];
	expected = plq_me(plq, lambda);
	gph = gph_plq(plq);
	gphme = gph_me(gph, lambda);
	actual = plq_gph(gphme);
	b = all(actual == expected | abs(actual - expected) < eps);
assert(all(all(b))); 
end

function [b] = testUpperBounded(testCase)
	eps = 1e-10;
	b = false;
	lambda = 3;
	% (x-1)^2+1 = x^2 - 2x + 1 + 1
	plq = [1,1,-2,2; 5,0,1,0; inf,0,0,inf];
	expected = plq_me(plq, lambda);
	gph = gph_plq(plq);
	gphme = gph_me(gph, lambda);
	actual = plq_gph(gphme);
	b = all(actual == expected | abs(actual - expected) < eps);
assert(all(all(b))); 
end

function [b] = testBounded(testCase)
	eps = 1e-10;
	b = false;
	lambda = 1.5;
	plq = [-3,0,0,inf; 0,1,0,3; 2,0,0,3; 5,0,1,1; inf,0,0,inf];
	expected = plq_me(plq, lambda);
	gph = gph_plq(plq);
	gphme = gph_me(gph, lambda);
	actual = plq_gph(gphme);
	b = all(actual == expected | abs(actual - expected) < eps);
    assert(all(all(b))); 
end

%function [b] = testMEnonconvex()
%	b = %	lambda = 1;
%	plqf=[-1,0,-1,-1;0,0,1,1;1,0,-1,1;%	result = plq_me(plqf,lambda,%	desired = [-2,0,-1,-1.5;0,0.5,1,0.5;2,0.5,-1,0.5;%	b = (result==desired);
%endfunction