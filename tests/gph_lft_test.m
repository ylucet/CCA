function tests = gph_lft_test()
tests = functiontests(localfunctions);
end
% Unit test file for gph_lft

function b = testIsBounded(testCase)
  g = [-1, 0, 0, 1;-1, -1, 1, 1;1, 0, 0, 1];%abs
  b = all(gph_isBounded(g)==[false false]);
  g = [-1 -1 1 1;-1 0 0 1;inf 0 0 inf];%I_[-1,1]
  b = b & all(gph_isBounded(g)==[true true]);
  g = [-1 -1 0 1;-1 0 0 1;inf 0 0 0.5];%(x<0?-x:x^2)^*
  b = b & all(gph_isBounded(g)==[true false]);
  g = [-1 0 1 1;-1 0 0 1;0.5 0 0 inf];%(x<0?x^2:-x)^*
  b = b & all(gph_isBounded(g)==[false true]);  
assert(all(all(b))); 
end

function [b] = testAbs(testCase)
	b = false;
	%abs function
	G = [-1, 0, 0, 1; ...
	     -1, -1, 1, 1; ...
	     1, 0, 0, 1];
	if ~gph_check(G) 
        return; 
	end;
	Gs = gph_lft(G);
    p = plq_gph(G);
    q=plq_lft(p);% I_[0,1]
    expected=gph_plq(q);	
	b = all(Gs == expected);
    assert(all(all(b))); 
end

function [b] = testInd(testCase)
	b = false;
	%indicator function I_[-1,1].
	G = [-1, -1, 1, 1; ...
	     -1, 0, 0, 1; ...
	     inf, 0, 0, inf];
	if ~gph_check(G) 
 return;  
	end;
	Gs = gph_lft(G);

	% Abs function
	expected = [-1, 0, 0, 1; ...
		    -1, -1, 1, 1; ...
		    1, 0, 0, 1];
	b = all(Gs == expected);
assert(all(all(b))); 
end

function [b] = testPL(testCase)
	b = false;
	% A piecewise linear function:
	%     x<0: y=-x
	%   0<x<1: y=0
	%     1<x: y=x-1
	G = [-1, 0, 0, 1, 1, 2; ...
	     -1, -1, 0, 0, 1, 1; ...
	     1, 0, 0, 0, 0, 1];
	if ~gph_check(G) 
 return;  
	end;
	Gs = gph_lft(G);

	expected = [-1, -1, 0, 0, 1, 1; ...
		    -1, 0, 0, 1, 1, 2; ...
		    inf, 0, 0, 0, 1, inf];
	b = all(Gs == expected);
assert(all(all(b))); 
end

function [b] = testPLQ1(testCase)
	b = false;
	% A PLQ function:
	%     x<-1: y=(x+1)^2
	%   -1<x<1: y=0
	%      1<x: y=(x-1)^2
	G = [-2, -1, 1, 2; ...
	     -2,  0, 0, 2; ...
	     1, 0, 0, 1];
	if ~gph_check(G) 
 return;  
	end;
	% The conjugate of the PLQ function is:
	%      x<0: y = 0.25*x^2 - x
	%      x>0: y = 0.25*x^2 + x	 
	Gs = gph_lft(G);
    p = plq_gph(G);q = plq_lft(p);Ge = gph_plq(q);
	b = gph_isEqual(Gs,Ge);
assert(all(all(b))); 
end

function [b] = testPLQ2(testCase)
	b = false;
	% A PLQ function:
	%   x in [-1,1]: 0
	%     otherwise: x^2 - 1
	G = [-2, -1, -1, 1, 1, 2; ...
	     -4, -2, 0, 0, 2, 4; ...
	     3, 0, 0, 0, 0, 3];
	if ~gph_check(G) 
 return;  
	end;
    % The conjugate of the PLQ function is:
    %     x<-2: y = 0.25*x^2 + 1
    %   -2<x<0: y = -x
    %    0<x<2: y = x
    %      2<x: y = 0.25*x^2 + 1
	Gs = gph_lft(G);
    p = plq_gph(G);q=plq_lft(p);Ge = gph_plq(q);
	b = gph_isEqual(Gs,Ge);
assert(all(all(b))); 
end

function [b] = testQuadratic(testCase)
  p=[inf,1,0,0];
  P=gph_plq(p);
  b=gph_check(P);
  Q=gph_lft(P);
  q=plq_lft(p);
  QQ=gph_plq(q);
  b = b & gph_isEqual(Q,QQ);
assert(all(all(b))); 
end

function [b] = testLinear(testCase)
  p=[inf,0,1,0];P=gph_plq(p);b=gph_check(P);
  Q=gph_lft(P);q=plq_lft(p);QQ=gph_plq(q);
  b = b & gph_isEqual(Q,QQ);
assert(all(all(b))); 
end

function [b] = testIndicatorSingleton(testCase)
  p=[1,0,0,2];
  P=gph_plq(p);
  b=gph_check(P);
  Q=gph_lft(P);
  q=plq_lft(p);
  QQ=gph_plq(q);
  b = b & gph_isEqual(Q,QQ);
assert(all(all(b))); 
end