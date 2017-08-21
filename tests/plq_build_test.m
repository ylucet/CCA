function tests = plq_build_test()
tests = functiontests(localfunctions);
end


% unit tests ==========================================================
%1st order model
function [b] = testexp(testCase)
	x=linspace(0,4)';
	plqf = plq_build(x,@exp,@exp);
	y=plq_eval(plqf,x);
	b = norm(y-exp(x))<1E-8;
    assert(all(all(b))); 
end

function [b] = testlinear(testCase)
	function y=f(x),y=2*x+1; 
	end;
	function dy=df(x),dy=2*ones(size(x)); 
	end;
	x=linspace(-2,2,5)';
	plqf = plq_build(x,@f,@df);
	y=plq_eval(plqf,x);
	b = norm(y-f(x))<1E-8;
assert(all(all(b)));
end

function [b] = testpartiallylinear(testCase)
	function y=f(x),i=find(x>0);y=zeros(size(x));y(i)=x(i).^2;end
	function y=df(x),i=find(x>0);y=zeros(size(x));y(i)=2*x(i);end
	x=linspace(-2,2,5)';
	plqf = plq_build(x,@f,@df);
	y=plq_eval(plqf,x);
	b = norm(y-f(x))<1E-8;
assert(all(all(b))); 
end

function [b] = testconjexp(testCase)
	function y=f(x),i1=find(x<0);i2=find(x==0);i3=find(x>0);y(i1)=inf*ones(size(i1));y(i2)=0;y(i3)=x(i3).*log(x(i3))-x(i3);end
	function y=df(x),i1=find(x<=0);i2=find(x>0);y(i1)=inf*ones(size(i1));y(i2)=log(x(i2));end
	x=linspace(0,20,3)';
	plqf = plq_build(x,@f,@df);
	y = plq_eval(plqf,x);
	yy=f(x);
    i=find(x==0);
    yy(i)=inf*ones(size(i));%plq evaluates inf at 0
	i=isinf(y);
    ii=isinf(yy);%need to test inf values separately
	b = (norm(y(~i)'-yy(~ii))<1E-8) & all(y(i)'==yy(i));
assert(all(all(b))); 
end

function [b] = testconjexp_d(testCase)
	function y=f(x),i1=find(x<0);i2=find(x==0);i3=find(x>0);y(i1)=inf*ones(size(i1));y(i2)=0;y(i3)=x(i3).*log(x(i3))-x(i3);end
	function y=df(x),i1=find(x<=0);i2=find(x>0);y(i1)=inf*ones(size(i1));y(i2)=log(x(i2));end
	x=linspace(0,20,3)';
	y=f(x);
    dy=df(x);
	plqf = plq_build_d(x,y,dy);
	y = plq_eval(plqf,x);
	yy=f(x);i=find(x==0);yy(i)=inf*ones(size(i));%plq evaluates inf at 0
	i=isinf(y);ii=isinf(yy);%need to test inf values separately
	b = (norm(y(~i)'-yy(~ii))<1E-8);
    b = b & all(y(i)'==yy(i));
assert(all(all(b))); 
end


%0th order model
function [b] = testexp0(testCase)
	x=linspace(0,4)';
	plqf = plq_build(x,@exp);
	y=plq_eval(plqf,x);
	b = norm(y-exp(x))<1E-8;
assert(all(all(b))); 
end

function [b] = testabs0(testCase)
	x=linspace(-4,4,5)';
	plqf = plq_build(x,@abs);
	b = [0,0,-1,0;inf,0,1,0]==plqf;
assert(all(all(b))); 
end

function [b] = testabs0_d(testCase)
	x=linspace(-4,4,5)';
	y=abs(x);
	plqf = plq_build_d(x,y);
	b = [0,0,-1,0;inf,0,1,0]==plqf;
assert(all(all(b))); 
end


function [b] = testx0(testCase)
	x=linspace(-4,4)';
	function y=f(x),y=x; 
	end;
	plqf = plq_build(x,@f);
	b = [inf,0,1,0]==plqf;
assert(all(all(b))); 
end

function [b] = testlinear0(testCase)
	x=linspace(-2,2,5)';function y=f(x),y=2*x+1; 
	end;
	plqf = plq_build(x,@f);
	b = [inf,0,2,1]==plqf;
assert(all(all(b))); 
end

function [b] = testpartiallylinear0(testCase)
	function y=f(x),i=find(x>0);y=zeros(size(x));y(i)=x(i).^2;end
	x=linspace(-2,2,5)';
	plqf = plq_build(x,@f);
	y=plq_eval(plqf,x);
	b = norm(y-f(x))<1E-8;
assert(all(all(b))); 
end

function [b] = testInf0(testCase)
  function y = f(x); ys = [inf;4/1;4/2;4/3;4/4;inf]; y = ys(double(x*4+1)); end

  x = 0:0.25:1.25;
  plqf = plq_build(x,@f,false,false,true);
  desired = [1/4,0,0,inf; 2/4,0,-8,6; 3/4,0,-8/3,10/3; 1,0,-4/3,7/3; inf,0,0,inf];
  b = plqf - desired < 1E-6 | plqf == desired;
  assert(all(all(b))); 
end

function [b] = testInf1(testCase)
  %function y = f(x); i=ieee(); ieee(2); y=ones(x)./x; ieee(i); endfunction
  %function s = df(x); i=ieee(); ieee(2); s=-ones(x)./(x.^2); ieee(i); endfunction
  function y = f(x); ys = [inf;4/1;4/2;4/3;4/4;inf]; y = ys(double(x*4+1)); end
  function dy = df(x); dys = -[inf;[4/1;4/2;4/3;4/4].^2;inf]; dy = dys(double(x*4+1)); end

  x = 0:0.25:1.25;

  plqf = plq_build(x,@f,@df,false,true);
  %desired = [0,0,0,inf; 1/3,0,-16,8; 0.6,0,-4,4; 6/7,0,-16/9,8/3; inf,0,-1,2];
  desired = [1/4,0,0,inf; 1/3,0,-16,8; 3/5,0,-4,4; 6/7,0,-16/9,8/3; 1,0,-1,2; inf,0,0,inf];
  b = plqf == desired | plqf - desired < 1E-6;
  assert(all(all(b))); 
end

function [b] = testNeedEvalFptr(testCase)
  b = false;
  x = 0:0.5:3;
  f1 = plq_build(x, @exp, false, false);
  f2 = plq_build(x, @exp, false, true);
  b = isequal(f1, f2);
assert(all(all(b))); 
end

function [b] = testNeedEvalFunc(testCase)
  function y=f(x)
    if (size(x) ~= [1,1]) 
 error('blah');  
    end;
	y=exp(x);
  end;
  b = false;
  x = 0:0.5:3;
  f1 = plq_build(x, @f, false, false);
  f2 = plq_build(x, @f, false, true);
  b = isequal(f1, f2);
assert(all(all(b)));
end

function [b] = testNonconvexfctn(testCase)
  b=false;
  x=linspace(0,2*pi,4)';
  result = plq_build(x,@sin,@cos);
  desired = []; %The desired result requires the x(i) values to be ordered. See result.
end

function [b] = testsoqs(testCase)
  function y = f(x);  ys=[.0;.3;.5;.2;.6;1.2;1.3;1.0;1.0;1.0;0;-1.0];y=ys(double(x+1)); end
  function dy = df(x); dys = [.5;1;0;-.2;5;4;0;-.2;-.2;.3;-.9999;-1.001]; dy = dys(double(x+1)); end
	x=linspace(0,11,12)';
	plqf = plq_build(x,@f,@df,true,false,'soqs');
	desired = [0,0,0,0; .9,-.25,.5,0; 1,4.75,-8.5,4.05; 1.2,-2,5,-2.7];
	b = (plqf(1:4,:) == desired) | abs(plqf(1:4,:) - desired) < 1E-6;
assert(all(all(b))); 
end

function [b] = testsoqs_noderiv(testCase)
  function y = f(x);  ys=[.0;.3;.5;.2;.6;1.2;1.3;1.0;1.0;1.0;0;-1.0];y=ys(double(x+1)); end
  function dy = df(x); dys = [.5;1;0;-.2;5;4;0;-.2;-.2;.3;-.9999;-1.001]; dy = dys(double(x+1)); end
	x=linspace(0,11,12)';
	plqf = plq_build(x,@f,false,true,false,'soqs');
	desired = [0,0,0,0; .5,-.06,.36,0; 1,-.06,.36,0];
	b = (plqf(1:3,:) == desired) | abs(plqf(1:3, :) - desired) < 1E-6;
assert(all(all(b))); 
end

function b = testsoqs1(testCase)
  function y=f(x), y=x.^4;end
  function dy=df(x), dy=4*x.^3;end
  x=linspace(-10,10,2)';
	p = plq_build(x,@f,@df,false,false,'soqs','bounded');
	d = [-10 0 0 inf;0 200 0 -10000;10 200 0 -10000;inf 0 0 inf];
	b = plq_isEqual(p, d);
assert(all(all(b))); 
end

function b = testsoqs2(testCase)
  function y=f(x), y=x.^4;end
  function dy=df(x), dy=4*x.^3;end
  x=linspace(-10,10,2)';
  b=false;
%  ierr=eval('plq_build(x,@f,@df,false,false,''soqs'',''wrongOption'');');
 % b=ierr~= 0;
%assert(all(all(b))) 
end
