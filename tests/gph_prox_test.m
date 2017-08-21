function tests = gph_prox_helper()
tests = functiontests(localfunctions);
end


%perform all tests
%P: input gph function
%lambda: input real number lambda >0
function b = helper(p, lambda)
  P=gph_plq(p);
  
  M=gph_me(P,lambda);%m=plq_me(p,lambda);
  R=gph_prox(P,lambda);%r=plq_prox(p,lambda);%monotone but nonconvex
  %since there is no plq_compose function
  %we numerically evaluate the moreau envelope
  %computed directly and through the proximal mapping
  dx=linspace(-10,10)';
  dy=gph_eval(R,dx);%dy=plq_eval(r,dx);

  dp=gph_eval(P,dy);%dp=plq_eval(p,dy);
  dz=dp+(dx-dy).^2/(2*lambda);

  dm=gph_eval(M,dx);%dm=plq_eval(m,dx);
  b=all((dm-dz)+1);
assert(b) 
end

%while we could avoid using plq functions, we prefer to use exactly
%the same tests as plg_prox without modifying unit test functions
%these functions are duplicated below.

function b = testLambdaNegative(testCase)
  p=[0 0 -1 0; inf 0 1 0];lambda =-2;
  P=gph_plq(p);
  b=false;
  try
    R=gph_prox(P,lambda);
  catch
    b= true; 
  end
assert(b) 
end

%function b = testLambdaNegative2()                % Not Required
%  p=[0 0 -1 0; %  b=%  b=_helper(p,lambda);
%endfunction


function b = testAbs(testCase)
  p=[0 0 -1 0; inf 0 1 0];lambda =2;
  b=helper(p,lambda);
assert(b) 
end

function b = testPLQ0(testCase)
	p=[inf 1 0 0];lambda=3;
    b=helper(p,lambda);
assert(b) 
end

function b = testPLQ1(testCase)
  % A PLQ function:
  %     x<-1: y=(x+1)^2
  %   -1<x<1: y=0
  %      1<x: y=(x-1)^2
  p=[-1 1 2 1;1 0 0 0;inf 1 -2 1];
  lambda=3;
  b=helper(p,lambda);
assert(b) 
end

function b = testPL(testCase)
	% A piecewise linear function:
	%     x<0: y=-x
	%   0<x<1: y=0
	%     1<x: y=x-1
	p = [0 0 -1 0;1 0 0 0;inf 0 1 -1];
  lambda=20;
  b=helper(p,lambda);
assert(b) 
end

function b = testPLQ2(testCase)
	% A PLQ function:
	%   x in [-1,1]: 0
	%     otherwise: x^2 - 1
  p=[-1 1 0 -1;1 0 0 0;inf 1 0 -1];
  lambda=3/4;
  b=helper(p,lambda);

assert(b) 
end

function b = testQuadratic(testCase)
  p=[inf,1,0,0];
  lambda=1/10;
  b=helper(p,lambda);
assert(b) 
end

function b = testLinear(testCase)
  p=[inf,0,1,0];
  lambda=1/3;
  b=helper(p,lambda);
assert(b) 
end

function b = testIndicatorSingleton(testCase)
  p=[1,0,0,2];
  lambda=30.5;
  b=helper(p,lambda);
assert(b) 
end

function b = testInd(testCase)
  p=[-1 0 0 inf;1 0 0 0 ;inf 0 0 inf];  lambda=10;
  b=helper(p,lambda);
assert(b) 
end

function b = test1(testCase)
  p=[0 0 -1 0; inf 0 1 0];lambda =2;
  P=gph_plq(p);  
  R=gph_prox(P,lambda);%R is monotone nonconvex
  b= ~gph_check(R,true);
assert(b) 
end