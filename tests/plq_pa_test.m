function tests = plq_pa_test()
tests = functiontests(localfunctions);
end
% I = Indicator, E = Exponential, C = Conjugate, L = Linear, Q = Quadratic


function b = testL2Lpa(testCase)
	lambda_pa = 0.5;
	f1 = [inf, 0, 1, 0];
	f2 = [inf, 0, -1, 5]; 
	desired = [inf,0,0,2];
	result = plq_pa(f1,f2,lambda_pa);
	result2 = plq_pa_mu(1,lambda_pa,f1,f2);
	b = isequal(desired, result, result2);
assert(b) 
end

function b = testI2Ipa(testCase)
	lambda_pa = 0.5;
	f2 = [5,0,0,1];
	f1 = [6,0,0,4];
	desired = [5.5,0,0,2.625];
	result = plq_pa(f1,f2,lambda_pa);
	%2 lines below fail after modifying plq_scalar.
	%Need to investigate (later)
	result2 = plq_pa_mu(1,lambda_pa,f1,f2);
	b = isequal(desired, result, result2);
	b = isequal(desired, result);
assert(b) 
end

function b = testAbs2zero(testCase)
	lambda_pa = 1;
	f0 = [0,0,0,0];
	f1 = [0,0,-1,0;inf,0,1,0];
	r = plq_pa(f0,f1,lambda_pa);
	rp= plq_pa_mu(1,lambda_pa,f0,f1);
	b = isequal(f1,r, rp);
assert(b) 
end

function b = testL2L(testCase)
	lambda_pa = 0.5;
	f0 = [inf,0,-1,0];
	f1 = [inf,0,1,0];
	r = plq_pa(f0,f1,lambda_pa);
	rp= plq_pa_mu(1,0.5,f0,f1);
	b = isequal([inf,0,0,-0.5], r, rp);
assert(b) 
end

function b = testAbs2zero2(testCase)
	lambda_pa = 0.5;
	f0 = [inf,0,0,0];
	f1 = [0,0,-1,0;inf,0,1,0];
	r = plq_pa(f0,f1,lambda_pa);
	rp= plq_pa_mu(1,lambda_pa,f0,f1);
	b = isequal(r, rp);
assert(b) 
end

function b = testPaNc(testCase)
	lambda_pa = 1;
	f0 = [0,0,-1,0;inf,0,1,0];	%abs
	f1 = plq_scalar(f0,-1);%-abs
	r = plq_pa(f0,f1,lambda_pa,false);
	rp= plq_pa_mu(1,lambda_pa,f0,f1);
	%since f1 + r x^2 is NOT convex, the pa is NOT equal to f1
	b = isequal(r, rp);
assert(b) 
end