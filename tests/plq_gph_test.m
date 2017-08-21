function tests = plq_gph_test()
tests = functiontests(localfunctions);
end
% Unit test file for plq_gph



function [b] = testAbs(testCase)
	b = false;
	%abs function
	gph = [-1, 0, 0, 1; ...
	       -1, -1, 1, 1; ...
	       1, 0, 0, 1];
	plq = plq_gph(gph);

        expected = [0,0,-1,0; inf,0,1,0];
        b = all(plq == expected);
assert(all(all(b))); 
end

function [b] = testInd(testCase)
	b = false;
	% The function I_[-1,1].
        gph = [-1, -1, 1, 1; ...
	       -1, 0, 0, 1; ...
	       inf, 0, 0, inf];
	plq = plq_gph(gph);

        expected = [-1,0,0,inf; 1,0,0,0; inf,0,0,inf];
        b = all(plq == expected);
assert(all(all(b))); 
end

function [b] = testPL(testCase)
	b = false;
	% A "	
    gph = [-1, 0, 0, 1, 1, 2; ...
	       -1, -1, 0, 0, 1, 1; ...
	       1, 0, 0, 0, 0, 1];
	plq = plq_gph(gph);

        expected = [0,0,-1,0; 1,0,0,0; inf,0,1,-1];
        b = all(plq == expected);
assert(all(all(b))); 
end

function [b] = testPLQ1(testCase)
	b = false;
	% A PLQ function:
	%     x<-1: y=(x+1)^2
	%   -1<x<1: y=0
	%      1<x: y=(x-1)^2
	gph = [-2, -1, 1, 2; ...
	       -2,  0, 0, 2; ...
	       1, 0, 0, 1];
	plq = plq_gph(gph);

        expected = [-1,1,2,1; 1,0,0,0; inf,1,-2,1];
        b = all(plq == expected);
assert(all(all(b))); 
end

function [b] = testPLQ2(testCase)
	b = false;
	% A PLQ function:
	%   x in [-1,1]: 0
	%     otherwise: x^2 - 1
	gph = [-2, -1, -1, 1, 1, 2; ...
	       -4, -2, 0, 0, 2, 4; ...
	       3, 0, 0, 0, 0, 3];
	plq = plq_gph(gph);

        expected = [-1,1,0,-1; 1,0,0,0; inf,1,0,-1];
        b = all(plq == expected);
assert(all(all(b))); 
end

function [b] = testFullDomain(testCase)
  b = false;
  p = [inf, 1, 0, 0];f=gph_plq(p);
  e=[-1 1;-2 2;1 1];
  b=all(f==e);
assert(all(all(b))); 
end

function [b] = testIndicator(testCase)
  b = false;
  p = [1, 0, 0, 1];f=gph_plq(p);
  e=[1 1;-1 1;1 1];
  b=all(f==e);
  assert(all(all(b))); 
end
