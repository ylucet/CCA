%% Author:   Mike Trienis
%% For:      Dr. Yves Lucet
%% Whatsit:  A test file for plq_add, adds two piecewise linear quadratic functions. 

%%mode(-1);
%%L: Linear, Q: Quadratic, I: Indicator, PW: Piecewise

%%__test_set = 'PLQ: plq_add';

function tests = plq_add_Test
    tests = functiontests(localfunctions);
end

function [b] = testQLQNonsmPlusQLQNonsm(testCase)
	b = 0;
	plqf = [-1,1,0,0;1,0,0,1;inf,1,0,0];
	plqg = [0,1,0,0;2,0,1,0;inf,1,0,-2];
	result=plq_add(plqf,plqg);
	desired = [-1,2,0,0;0,1,0,1;1,0,1,1;2,1,1,0;inf,2,0,-2];          
	b = all(result==desired);
end

function [b] = testQQSmoothPlusQQSmooth(testCase)
	b = 0;
	plqf = [-1,1,1,1; inf,1,1,1];
	plqg = [-2,1,1,0; inf,1,1,0];
	result = plq_add(plqf,plqg);
	desired = [inf,2,2,1];          
	b = all(result==desired);
end

%%Note this function tests when there is a common point between the two PLQ functions
function [b] = testQLSmoothPlusQLQNonsm(testCase)
	b = 0;
	plqf=[1,1,0,0;3, 0, 2, -1;inf,3,-16,26];
	plqg=[0,1,0,0;1, 0, 1, 0;inf,3, -4, 2];
	result = plq_add(plqf,plqg);
	desired = [0,2,0,0;1,1,1,0;3,3,-2,1;inf,6,-20,28];          
	b = all(result==desired);
end

function [b] = testIPlusQ(testCase)
	b = 0;
	plqf=[4,0,0,5];
	plqg=[inf,1/2,0,0];
	result = plq_add(plqf,plqg);
	desired = [4,0,0,13];
	b = all(result==desired);
end

function [b] = testIPlusQPW(testCase)
	b = 0;
	plqf=[4,0,0,5];
	plqg=[0,0,-1,0;inf,0,1,0];
	result = plq_add(plqf,plqg);
	desired = [4,0,0,9];          
	b = all(result==desired);
end

function [b] = testIPlusQPW2(testCase)
	b = 0;
	plqg=[4,0,0,5];
	plqf=[0,0,-1,0;inf,0,1,0];
	result = plq_add(plqf,plqg);
	desired = [4,0,0,9];          
	b = all(result==desired);
end

function [b] = testIPlusPL(testCase)
	b = 0;
	Ii=[-0.5,0,0,inf;0.5,0,0,0;inf,0,0,inf];
	plq=[-1,0,-1,-1;0,0,1,1;1,0,-1,1;inf,0,1,-1];
	result = plq_add(Ii,plq);
	desired = [-0.5,0,0,inf;0,0,1,1;0.5,0,-1,1;inf,0,0,inf];
	b = all(result==desired);
end

function [b] = testIPlusI(testCase)
  b = 0;
  f1 = [1,0,0,3];
  f2 = [1,0,0,10];
  result = plq_add(f1, f2);
  desired = [1,0,0,13];
  b = isequal(desired, result);
end

function [b] = testIPlusI2(testCase)
  b = 0;
  f1 = [1,0,0,3];
  f2 = [2,0,0,10];
  result = plq_add(f1, f2);
  desired = [inf,0,0,inf];
  b = isequal(desired, result);
end

