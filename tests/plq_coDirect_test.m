function tests = plq_coDirect_test()
tests = functiontests(localfunctions);
end
% Author:   Mike Trienis
% For:      Dr. Yves Lucet
% Whatsit:  A test file for plq convex hull functions plq_coDirect and _plq_conv_on_interval

% I = Indicator, E = Exponential, C = Conjugate, L = Linear, Q = Quadratic



function [b] = testNCExt_1(testCase)
	% testL2Lch_1 in test_plq_coSplit.sci.
	% Bounded on both sides.
	b = false;
	plqf = [-1,0,0,inf; 1,0,1,-1; 4,0,0,0; inf,0,0,inf];
	[result, iters] = plq_coDirect(plqf);
	desired = [-1,0,0,inf; 4,0,0.4,-1.6; inf,0,0,inf];
	if size(result) == size(desired) 

		b = all(result == desired | abs(result - desired) < 1E-5);
		b = b & (iters == 1);
	else
		b = false;
	end;
assert(all(all(b))) 
end

function [b] = testNCExt_2(testCase)
	% Bounded on the left, co is slanted.
	b = false;
	plqf = [1,0,1,-1; 4,0,0,0; inf,0,0,inf];
	[result, iters] = plq_coDirect(plqf);
	desired = [4,0,1,-4; inf,0,0,inf];
	if size(result) == size(desired) 

		b = all(result == desired | abs(result - desired) < 1E-5);
		b = b & (iters == 1);
	else
		b = false;
	end;
assert(all(all(b))) 
end

function [b] = testNCExt_3(testCase)
	% Bounded on the right, co is flat.
	b = false;
	plqf = [-1,0,0,3; 3,0,-1,2; inf,0,0,inf];
	[result, iters] = plq_coDirect(plqf);
	desired = [3,0,0,-1; inf,0,0,inf];
	if size(result) == size(desired) 

		b = all(result == desired | abs(result - desired) < 1E-5);
		b = b & (iters == 1);
	else
		b = false;
	end;
assert(all(all(b))) 
end

function [b] = testNCExt_4(testCase)
	% Bounded upside down quadratic.
	b = false;
	plqf = [-1,0,0,inf; 2,-1,0,1; inf,0,0,inf];
	[result, iters] = plq_coDirect(plqf);
	desired = [-1,0,0,inf; 2,0,-1,-1; inf,0,0,inf];
	if size(result) == size(desired) 

		b = all(result == desired | abs(result - desired) < 1E-5);
		b = b & (iters == 0);
	else
		b = false;
	end;
assert(all(all(b))) 
end

%---------------------------%

function [b] = testQ2Lch_1(testCase)
	b = false;
	plqf = [0,1,0,0;3,0,0,0];
	f1 = plqf(1,:);
  f2 = plqf(2,:);
  x1=-2.5;
  x3=f1(1,1);
  x5=f2(1,1);
	result = plq_conv_on_interval(f1,f2,x1,x3,x5);
  desired = plqf;          
	b = all(abs(result-desired) < 1E-5);
assert(all(all(b))) 
end


function [b] = testL2Qch_2(testCase)
	b = false;
	plqf = [-1,0,0,1;3,1,0,0];
	f1 = plqf(1,:);
  f2 = plqf(2,:);
  x1=-2.5;
  x3=f1(1,1);
  x5=f2(1,1);
	result = plq_conv_on_interval(f1,f2,x1,x3,x5);
  desired = [-0.2087122,0,-0.4174243,-0.0435608;3,1,0,0];          
	b = all(abs(result-desired) < 1E-5);
assert(all(all(b))) 
end

function [b] = testL2Qch_3(testCase)
	b = false;
	plqf = [0,0,0,0;2,-1,0,0];
	f1 = plqf(1,:);
  f2 = plqf(2,:);
  x1=-2;
  x3=f1(1,1);
  x5=f2(1,1);
	result = plq_conv_on_interval(f1,f2,x1,x3,x5);
  desired =[2,0,-1,-2];         
	b = all(abs(result-desired) < 1E-5);
assert(all(all(b))) 
end

function [b] = testQ2Lch_3(testCase)
	b = false;
	plqf = [1,1,0,0;4,0,0,1]; 
	f1 = plqf(1,:);
  f2 = plqf(2,:);
  x1=-2.5;
  x3=f1(1,1);
  x5=f2(1,1);
	result = plq_conv_on_interval(f1,f2,x1,x3,x5);
  desired = [0.1270167,1,0,0;4,0,0.2540333,-0.0161332];          
	b = all(abs(result-desired) < 1E-5);
assert(all(all(b))) 
end

function [b] = testQ2Lch_4(testCase)
	b = false;
	plqf = [1,-1,0,1;3,0,0,0];
	f1 = plqf(1,:);
  f2 = plqf(2,:);
  x1=-2;
  x3=f1(1,1);
  x5=f2(1,1);
	result = plq_conv_on_interval(f1,f2,x1,x3,x5);
	desired = [3,0,0.6,-1.8];  
	b = all(abs(result-desired) < 1E-5);
assert(all(all(b))) 
end

function [b] = testQ2Lch_5(testCase)
    % This test was added to test the x(1)==-inf & x(5)==inf &
    % a(1)<>0 & a(2)==0 case of _plq_conv_buildl.

    % _plq_conv_on_interval:
    % a(1) >= 0, a(2) >= 0
    % a(1) <> 0, a(2) == 0
    % a(1) > 0, a(2) == 0

    % _conv_interval_func:
    % (a(1) == 0 | x(5) == inf) & (a(2) == 0 | x(1) <> -inf)
    % x(5) == inf, a(2) == 0

    % _plq_conv_buildl:
    % a(1) > 0, a(2) == 0
    % x(1) == -inf, x(5) == inf

    b = false;
    plqf = [0,1,1,0;inf,0,0,0];
    result = plq_conv_on_interval(plqf(1,:), plqf(2,:), -inf, 0, inf);
    result(end,1)=0;
    desired = [-0.5,1,1,0;0,0,0,-0.25];
    b = all(norm(result-desired) < 1E-5);
assert(all(all(b))) 
end

function [b] = testQ2Qch_1(testCase)
	b = false;
	plqf = [3/2,1,0,0;3,1,-4,6];
	f1 = plqf(1,:);
  f2 = plqf(2,:);
  x1=-2.5;
  x3=f1(1,1);
  x5=f2(1,1);
  result = plq_conv_on_interval(f1,f2,x1,x3,x5);
  desired=[0.5,1,0,0;2.5,0,1,-0.25;3,1,-4,6];         
	b = all(abs(result-desired) < 1E-5 | result == desired);
assert(all(all(b))) 
end

   
function [b] = testQ2Qch_2(testCase)
	b = false;
	plqf = [0,1,1,2;5,1,-1,2];
	f1 = plqf(1,:);
  f2 = plqf(2,:);
  x1=-2.5;
  x3=f1(1,1);
  x5=f2(1,1);
	result = plq_conv_on_interval(f1,f2,x1,x3,x5);
	desired=[-0.5,1,1,2;0.5,0,0,1.75;5,1,-1,2];      
	b = all(abs(result-desired) < 1E-5);
assert(all(all(b))) 
end

function [b] = testQ2Qch_3(testCase)
	b = false;
	plqf = [0,2,4,0;2,2,-4,0];
	f1 = plqf(1,:);
  f2 = plqf(2,:);
  x1=-2;
  x3=f1(1,1);
  x5=f2(1,1);
	result = plq_conv_on_interval(f1,f2,x1,x3,x5);
	desired =[-1,2,4,0;1,0,0,-2;2,2,-4,0];       
	b = all(abs(result-desired) < 1E-5);
assert(all(all(b))) 
end

function [b] = testQ2Qch_4(testCase)
	b = false;
	plqf = [1,-1,0,2;5,1,-4,4];
	f1 = plqf(1,:);
  f2 = plqf(2,:);
  x1=-2;
  x3=f1(1,1);
  x5=f2(1,1);
	result = plq_conv_on_interval(f1,f2,x1,x3,x5);
	desired=[2.2426407,0,0.4852814,-1.0294373;5,1,-4,4];        
	b = all(abs(result-desired) < 1E-5);
assert(all(all(b))) 
end

function [b] = testQ2Qch_5(testCase)
	b = false;
	plqf = [0,-1,-4,0;2,-1,4,0];
	f1 = plqf(1,:);
  f2 = plqf(2,:);
  x1=-2;
  x3=f1(1,1);
  x5=f2(1,1);
	result = plq_conv_on_interval(f1,f2,x1,x3,x5);
	desired=[0,0,-2,0;2,0,2,0];       
	b = all(abs(result-desired) < 1E-5);
assert(all(all(b))) 
end

function [b] = testQ2Qch_6(testCase)
	b = false;
	plqf = [0,2,4,0;inf,2,-4,0];
	[result, iters] = plq_coDirect(plqf); result(end,1)=0;
	desired=[-1,2,4,0;1,0,0,- 2;inf,2,-4,0]; desired(end,1)=0;
	b = (iters == 1) & all(norm(result-desired) < 1E-5);
assert(all(all(b))) 
end

function [b] = testQ2Qch_7(testCase)
    % This test was added to test the x(1)==-inf & x(5)==inf &
    % a(1)<>0 & a(2)==0 case of _plq_conv_buildl.

    % _plq_conv_on_interval:
    % a(1) <> 0, a(2) <> 0

    % _conv_interval_func:
    % (a(1) == 0 | x(5) == inf) & (a(2) == 0 | x(1) <> -inf)
    % x(5) == inf, a(2) == 0

    % _plq_conv_buildl:
    % a(1) <> 0, a(2) <> 0

    b = false;
    plqf = [0,2,1,0;inf,1,0,0];
    result = plq_conv_on_interval(plqf(1,:), plqf(2,:), -inf, 0, inf);
    desired = [-0.1464466,2,1,0;0.2071068,0,0.4142136,-0.0428932;inf,1,0,0];
    b = (all(abs(result - desired) < 1E-5 | result == desired));
    assert(all(all(b))) 
end

%---------------------------%

function [b] = testL2L2Qch_7(testCase)
	b = false;
	plqf = [0,0,1,0;2,0,0,0;inf,1,-4,4];
	[result, iters] = plq_coDirect(plqf); result(end,1)=0;
	desired  = [2.5,0,1,-2.25;inf,1,-4,4];  desired(end,1)=0;
	b = (iters == 2) & all(norm(result-desired) < 1E-5);
assert(all(all(b))) 
end

function [b] = testQ2Q2Qch_8(testCase)
	b = false;
	plqf =[-2,1,8,16;2,-1,0,8;inf,1,-8,16]; 
	[result, iters] = plq_coDirect(plqf); 
    result(end,1)=0;
	desired  = [-4,1,8,16;4,0,0,0;inf,1,-8, 16]; desired(end,1)=0; 
	b = (iters == 3) & all(norm(result-desired) < 1E-5);
assert(all(all(b))) 
end

%---------------------------%

function [b] = testQ2L2L2Qch_10(testCase)
	b = false;
	plqf =[-3,1,8,16;0,0,1,4;3,0,-1,4;inf,1,-8,16]; 
	[result, iters] = plq_coDirect(plqf); result(end,1)=0;
	desired =  [-4,1,8,16;4,0,0,0;inf,1,-8,16];  desired(end,1)=0; 
	b = (iters == 3) & all(norm(result-desired) < 1E-5);
assert(all(all(b))) 
end

function [b] = testQ2L2L2Qch_11(testCase)
	b = false;
	plqf =[-3,1,8,16;0,0,-1,-2;3,0,1,-2;inf,1,-8,16]; 
	[result, iters] = plq_coDirect(plqf); result(end,1)=0;
	desired = [-4.2426407,1,8,16;0,0,-0.4852814,-2;4.2426407,0,0.4852814,-2;inf,1,-8,16]; desired(end,1)=0; 
	b = (iters == 3) & all(norm(result-desired) < 1E-5);
assert(all(all(b))) 
end

%---------------------------%

function [b] = testL2Q2Lch_12(testCase)
	b = false;
	plqf =[-2,0,-1,10;2,1,0,8;inf,0,1,10];  
	[result, iters] = plq_coDirect(plqf); result(end,1)=0;
	desired=[-0.5,0,-1,7.75;0.5,1,0,8;inf,0,1,7.75];  desired(end,1)=0;     
	b = (iters == 2) & all(norm(result-desired) < 1E-5);
assert(all(all(b))) 
end

function [b] = testL2Q2Lch_13(testCase)
	b = false;
	plqf =[-2,0,-1,2;1,-1,0,8;inf,0,1,6]; 
	[result, iters] = plq_coDirect(plqf); result(end,1)=0;
	desired=[- 2,0,-1,2;inf,0,1,6]; desired(end,1)=0; 
	b = (iters == 1) & all(norm(result-desired) < 1E-5);
assert(all(all(b))) 
end

%---------------------------%

function [b] = testPosInfHull_0(testCase)
	b = false;
	plqf = [inf,0,0,inf];
	[result, iters] = plq_coDirect(plqf);
	desired = [inf,0,0,inf];
	b = (iters == 0) & (result == desired);
assert(all(all(b))) 
end

function [b] = testNegInfHull_0(testCase)
	b = false;
	plqf = [inf,0,0,-inf];
	[result, iters] = plq_coDirect(plqf);
	desired = [inf,0,0,-inf];
	b = (iters == 0) & (result == desired);
assert(all(all(b))) 
end

function [b] = testNegInfHull_1(testCase)
    b = false;
	plqf = [0,-1,-2,1;1,0,0,1;inf,1,1,-1];
	[result, iters] = plq_coDirect(plqf);
	desired = [inf,0,0,-inf];
	b = (iters == 0) & (result == desired);
assert(all(all(b))) 
end

function [b] = testNegInfHull_2(testCase)
    b = false;
	plqf = [-1,1,4,3;1,0,2.5,2.5;3,1,-2,6;inf,-2,12,-9];
	[result, iters] = plq_coDirect(plqf);
	desired = [inf,0,0,-inf];
	b = (iters == 0) & (result == desired);
assert(all(all(b))) 
end

function [b] = testNegInfHull_3(testCase)
    b = false;
	plqf = [0,0,-1,0;1,1,0,0;inf,0,-2,3];
	[result, iters] = plq_coDirect(plqf);
	desired = [inf,0,0,-inf];
	b = (iters == 0) & (result == desired);
assert(all(all(b))) 
end

                                    
