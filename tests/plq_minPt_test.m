function tests = plq_minPt_test()
  tests = functiontests(localfunctions);
end
% I = Indicator, E = Exponential, C = Conjugate, L = Linear, Q = Quadratic


function b = prim(p, fmin, xmin)
  [fm,xm] = plq_minPt(p);
  b = isequal(fmin,fm) & isequal(xmin,xm);
end

function b = test1(testCase)
	p = [inf, 0, 1, 0];
	fmin = -inf;xmin = [];
	b = prim(p,fmin,xmin);
assert(b) 
end

function b = test1b(testCase)
	p = [inf, 0, 0, 3];
	fmin = 3;xmin = [0];
	b = prim(p,fmin,xmin);
assert(b) 
end

function b = test2(testCase)
	p = [inf, 1, 0, 0];
	fmin = 0;xmin = 0;
	b = prim(p,fmin,xmin);
assert(b) 
end

function b = test3(testCase)
	p = [0 0 -1 0;inf, 0, 1, 0];%abs
	fmin = 0;xmin = 0;
	b = prim(p,fmin,xmin);
assert(b) 
end

function b = test4(testCase)
	p = [-1 0 -1 -1;0 0 1 1;1 0 -1 1;inf, 0, 1, -1];
	fmin = 0;xmin = [-1;1];
	b = prim(p,fmin,xmin);
assert(b) 
end

function b = test5(testCase)
    %local + global min
	p =[-3 0 -0.5 -0.5;-2 0  2 7;0 0 -0.5 2;inf 0 2 2];
	fmin = 1;xmin = -3;
	b = prim(p,fmin,xmin);
assert(b) 
end

function b = test6(testCase)
	p = [-1 0 0 inf;1 0 0 0;inf 0 0 inf];%I_[-1,1]
	fmin = 0;xmin = [1];%xmin=[-1;1];	b = prim(p,fmin,xmin);
end

function b = test7(testCase)
	p = [1 0 0 2];%I_{1} + 2
	fmin = 2;xmin = [1];
	b = prim(p,fmin,xmin);
end

function b = test8(testCase)
 p  = [-15.495963    0.         -0.6666667  -2.2597654;
  -5.3940994    0.0058845  -0.4842946  -0.8467499;
  -4.002795     0.100625     0.5377847    1.9098488;
  -3.8909938  -0.0993827  -1.0633951  -1.2947485;
  -0.3961698    0.100625     0.4930625    1.7333349;
    0.9454451  -0.0993827    0.3345885    1.7019436;
    4.1586957    0.100625   -0.0436042    1.8807238;
    10.626398    0.0803995    0.1246192    1.5309288;
   inf          0.           1.8333333  -7.5478088];
	xmin = -p(5,3)/2/p(5,2);fmin = plq_eval(p,xmin);
	b = prim(p,fmin,xmin);
end
 
function b = test9(testCase) 
  %create a test where -b/2/a is not in interval
    p = [inf 1 0 0];q=[inf 0 -1 0.5];
    p = plq_max(p,q);q=[inf 0 1 0.5];
    p = plq_max(p,q);
	fmin = 0.5;xmin = 0;
	b = prim(p,fmin,xmin);
end
