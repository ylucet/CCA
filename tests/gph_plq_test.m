function tests = gph_plq_test()
tests = functiontests(localfunctions);
end
% Unit test file for gph_plq



function b = testAbs(testCase)
	%abs function
  p = [0,0,-1,0;inf,0,1,0];
  G = gph_plq(p);
  E = [-1, 0, 0, 1; -1, -1, 1, 1; 1, 0, 0, 1];
  b = all(G==E);
assert(all(all(b))) ;
end

function b = testQuartic(testCase)
  function y=f(x), y=x.^4;end
  function dy=df(x), dy=4*x.^3;end
  x=linspace(-2,2,4)';
  
  p=plq_build(x,@f,@df,true,false,'soqs','bounded');
  P=gph_plq(p);
  pg=plq_gph(P);
  b=plq_isEqual(p,pg);
assert(all(all(b))) 
end

 

function [b] = testInd(testCase)
	b = false;
	% The function I_[-1,1].
        plq = [-1,0,0,inf; 1,0,0,0; inf,0,0,inf];
        gph = gph_plq(plq);

        expected = [-1, -1, 1, 1; ...
	            -1, 0, 0, 1; ...
                    inf, 0, 0, inf];
        b = all(gph == expected);
assert(all(all(b))) 
end

function [b] = testPL(testCase)
	b = false;
    plq = [0,0,-1,0; 1,0,0,0; inf,0,1,-1];
        gph = gph_plq(plq);

	expected = [-1, 0, 0, 1, 1, 2; ...
                    -1, -1, 0, 0, 1, 1; ...
                    1, 0, 0, 0, 0, 1];
        b = all(gph == expected);
assert(all(all(b))) 
end

function [b] = testPLQ1(testCase)
	b = false;
	% A PLQ function:
	%     x<-1: y=(x+1)^2
	%   -1<x<1: y=0
	%      1<x: y=(x-1)^2
        plq = [-1,1,2,1; 1,0,0,0; inf,1,-2,1];
        gph = gph_plq(plq);

	expected = [-2, -1, 1, 2; ...
                    -2,  0, 0, 2; ...
                    1, 0, 0, 1];
        b = all(gph == expected);
assert(all(all(b))) 
end

function b = testPLQ2(testCase)
	b = false;
	% A PLQ function:
	%   x in [-1,1]: 0
	%     otherwise: x^2 - 1
        plq = [-1,1,0,-1; 1,0,0,0; inf,1,0,-1];
        gph = gph_plq(plq);

	expected = [-2, -1, -1, 1, 1, 2; ...
                    -4, -2, 0, 0, 2, 4; ...
                    3, 0, 0, 0, 0, 3];
        b = all(gph == expected);
assert(all(all(b))) 
end

function b = testFullDomain(testCase)
  p = [inf,1,0,0];
  gph = gph_plq(p);
  ge = [-1 1;-2 2;1 1];
  b = gph_isEqual(gph,ge);
assert(all(all(b))) 
end

function b = testIndicator(testCase)
  p = [2,0,0,1];
  gph = gph_plq(p);
  ge = [2 2;-1 1;1 1];
  b = gph_isEqual(gph,ge);
assert(all(all(b))) 
end


function [b] = runTestFile(testCase)
          b = true;
          b = checkForFail(testWrapper(testAbs,'testAbs'), b);
          b = checkForFail(testWrapper(testQuartic,'testQuartic'), b);          
          b = checkForFail(testWrapper(testInd,'testInd'), b);
          b = checkForFail(testWrapper(testPL,'testPL'), b);
          b = checkForFail(testWrapper(testPLQ1,'testPLQ1'), b);
          b = checkForFail(testWrapper(testPLQ2,'testPLQ2'), b);
          b = checkForFail(testWrapper(testFullDomain,'testFullDomain'), b);
          b = checkForFail(testWrapper(testIndicator,'testIndicator'), b);          
assert(all(all(b))) 
end
