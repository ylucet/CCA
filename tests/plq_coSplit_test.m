function tests = plq_coSplit_test()
tests = functiontests(localfunctions);
end
% Author:   Mike Trienis, Bryan Gardiner
% For:      Dr. Yves Lucet
% Whatsit:  A test file for plq convex hull function plq_coSplit.

% I = Indicator, E = Exponential, C = Conjugate, L = Linear, Q = Quadratic



function [b] = testPointIndicator(testCase)
	b = false;
	plqf = [5,0,0,10];
	result = plq_coSplit(plqf);
	b = all(plqf == result);
assert(all(all(b))); 
end

function [b] = testConcaveQ(testCase)
	b = false;
	plqf = [-1,0,0,inf; 2,-1,0,1; inf,0,0,inf];
	result = plq_coSplit(plqf);
	expected = [-1,0,0,inf; 2,0,-1,-1; inf,0,0,inf];
	b = all(result == expected);
assert(all(all(b))); 
end

%---------------------------%

function [b] = testL2Lch_1(testCase)
	b = false;
	plqf = [-1,0,0,inf; 1,0,1,-1; 4,0,0,0; inf,0,0,inf];
	result = plq_coSplit(plqf);
	desired = [-1,0,0,inf; 4,0,0.4,-1.6; inf,0,0,inf];
	b = all(result == desired | abs(result - desired) < 1E-5);
assert(all(all(b))); 
end

function [b] = testL2L2L2Lch_2(testCase)
	b = false;
	plqf = [0,0,0,inf; 1,0,-1,1; 2,0,1,-1; 3,0,-1,3; 4,0,1,-3; inf,0,0,inf];
	result = plq_coSplit(plqf);
	desired = [0,0,0,inf; 1,0,-1,1; 3,0,0,0; 4,0,1,-3; inf,0,0,inf];
	b = (result == desired | abs(result - desired) < 1E-5);
assert(all(all(b))); 
end

function [b] = testQ2L2Qch_3(testCase)
	b = false;
	plqf = [-1,1/2,0,1; 1,0,-2,-0.5; inf,1,-2,-1.5];
	result = plq_coSplit(plqf);
	desired = plq_co(plqf);
	b = (result == desired | abs(result - desired) < 1E-5);
assert(all(all(b))); 
end

function [b] = testQ2Qch_6(testCase)
	b = false;
	plqf = [0,2,4,0;inf,2,-4,0];
	result = plq_coSplit(plqf); result(end,1)=0;
	desired=[-1,2,4,0;1,0,0,- 2;inf,2,-4,0]; desired(end,1)=0;
	b = all(norm(result-desired) < 1E-5);
assert(all(all(b))); 
end

%---------------------------%

function [b] = testL2L2Qch_7(testCase)
	b = false;
	plqf = [0,0,1,0;2,0,0,0;inf,1,-4,4];
	result = plq_coSplit(plqf); result(end,1)=0;
	desired  = [2.5,0,1,-2.25;inf,1,-4,4];  desired(end,1)=0;
	b = all(norm(result-desired) < 1E-5);
assert(all(all(b))); 
end

function [b] = testQ2Q2Qch_8(testCase)
	b = false;
	plqf =[-2,1,8,16;2,-1,0,8;inf,1,-8,16]; 
	result = plq_coSplit(plqf); result(end,1)=0;
	desired  = [-4,1,8,16;4,0,0,0;inf,1,-8, 16]; desired(end,1)=0; 
	b = all(norm(result-desired) < 1E-5);
assert(all(all(b))); 
end

%---------------------------%

function [b] = testQ2Q2Qch_9(testCase)
	b = false;
	plqf =[-2,1,8,16;2,-1,0,8;inf,1,-8,16]; 
	result = plq_coSplit(plqf); result(end,1)=0;
	desired=[-4,1,8,16;4,0,0,0;inf,1,-8,16]; desired(end,1)=0;   
	b = all(norm(result-desired) < 1E-5);
assert(all(all(b))); 
end

function [b] = testQ2L2L2Qch_10(testCase)
	b = false;
	plqf =[-3,1,8,16;0,0,1,4;3,0,-1,4;inf,1,-8,16]; 
	result = plq_coSplit(plqf); result(end,1)=0;
	desired =  [-4,1,8,16;4,0,0,0;inf,1,-8,16];  desired(end,1)=0; 
	b = all(norm(result-desired) < 1E-5);
assert(all(all(b))); 
end

function [b] = testQ2L2L2Qch_11(testCase)
	b = false;
	plqf =[-3,1,8,16;0,0,-1,-2;3,0,1,-2;inf,1,-8,16]; 
	result = plq_coSplit(plqf); result(end,1)=0;
	desired = [-4.2426407,1,8,16;0,0,-0.4852814,-2;4.2426407,0,0.4852814,-2;inf,1,-8,16]; desired(end,1)=0; 
	b = all(norm(result-desired) < 1E-5);
assert(all(all(b))); 
end

%---------------------------%

function [b] = testL2Q2Lch_12(testCase)
	b = false;
	plqf =[-2,0,-1,10;2,1,0,8;inf,0,1,10];  
	result = plq_coSplit(plqf); result(end,1)=0;
	desired=[-0.5,0,-1,7.75;0.5,1,0,8;inf,0,1,7.75];  desired(end,1)=0;     
	b = all(norm(result-desired) < 1E-5);
assert(all(all(b))); 
end

function [b] = testL2Q2Lch_13(testCase)
	b = false;
	plqf =[-2,0,-1,2;1,-1,0,8;inf,0,1,6]; 
	result = plq_coSplit(plqf); result(end,1)=0;
	desired=[- 2,0,-1,2;inf,0,1,6]; desired(end,1)=0; 
	b = all(norm(result-desired) < 1E-5);
assert(all(all(b))); 
end

%---------------------------%

function [b] = testPosInfHull_0(testCase)
	b = false;
	plqf = [inf,0,0,inf];
	result = plq_coSplit(plqf);
	desired = [inf,0,0,inf];
	b = (result == desired);
assert(all(all(b))); 
end

function [b] = testNegInfHull_0(testCase)
	b = false;
	plqf = [inf,0,0,-inf];
	result = plq_coSplit(plqf);
	desired = [inf,0,0,-inf];
	b = (result == desired);
assert(all(all(b))); 
end

function [b] = testNegInfHull_1(testCase)
    b = false;
	plqf = [0,-1,-2,1;1,0,0,1;inf,1,1,0];
	result = plq_coSplit(plqf);
	desired = [inf,0,0,-inf];
	b = (result == desired);
assert(all(all(b))); 
end

function [b] = testNegInfHull_2(testCase)
    b = false;
	plqf = [-1,1,4,3;1,0,2.5,2.5;3,1,-2,6;inf,-2,12,-9];
	result = plq_coSplit(plqf);
	desired = [inf,0,0,-inf];
	b = (result == desired);
assert(all(all(b))); 
end
  
function [b] = testNegInfHull_3(testCase)
    b = false;
	plqf = [0,0,-1,0;1,1,0,0;inf,0,-2,3];
	result = plq_coSplit(plqf);
	desired = [inf,0,0,-inf];
	b = (result == desired);
assert(all(all(b))); 
end
                                     
%---------------------------%

function [b] = runTestFile(testCase)
	b = true;
  	b = checkForFail(testWrapper(testPointIndicator, 'testPointIndicator'), b);
  	b = checkForFail(testWrapper(testConcaveQ, 'testConcaveQ'), b);
  	b = checkForFail(testWrapper(testL2Lch_1, 'testL2Lch_1'), b);
  	b = checkForFail(testWrapper(testL2L2L2Lch_2, 'testL2L2L2Lch_2'), b);
  	b = checkForFail(testWrapper(testQ2L2Qch_3, 'testQ2L2Qch_3'), b);
  	b = checkForFail(testWrapper(testQ2Qch_6, 'testQ2Qch_6'), b);
  	b = checkForFail(testWrapper(testL2L2Qch_7, 'testL2L2Qch_7'), b);
  	b = checkForFail(testWrapper(testQ2Q2Qch_8, 'testQ2Q2Qch_8'), b);
  	b = checkForFail(testWrapper(testQ2Q2Qch_9, 'testQ2Q2Qch_9'), b);
  	b = checkForFail(testWrapper(testQ2L2L2Qch_10, 'testQ2L2L2Qch_10'), b);
  	b = checkForFail(testWrapper(testQ2L2L2Qch_11, 'testQ2L2L2Qch_11'), b);
  	b = checkForFail(testWrapper(testL2Q2Lch_12, 'testL2Q2Lch_12'), b);
  	b = checkForFail(testWrapper(testL2Q2Lch_13, 'testL2Q2Lch_13'), b);
  	b = checkForFail(testWrapper(testPosInfHull_0, 'testPosInfHull_0'), b);
  	b = checkForFail(testWrapper(testNegInfHull_0, 'testNegInfHull_0'), b);
  	b = checkForFail(testWrapper(testNegInfHull_1, 'testNegInfHull_1'), b);
  	b = checkForFail(testWrapper(testNegInfHull_2, 'testNegInfHull_2'), b);
  	b = checkForFail(testWrapper(testNegInfHull_3, 'testNegInfHull_3'), b);
assert(all(all(b))); 
end
