function tests = plq_max_test()
tests = functiontests(localfunctions);
end

%L: Linear, Q: Quadratic, I: Indicator, PW: Piecewise



function [b] = testLLMax(testCase)
	b = false;	
	plqf1 = [inf,0,1,0];
	plqf2 = [inf,0,-1,0];
	result = plq_max(plqf1,plqf2);
%	x=linspace(-5,5,25)';
%	ymax = plq_eval(result,x);
% plot2d(x,ymax);
	desired = [0,0,-1,0;inf,0,1,0];          
	b = all(result==desired);
assert(all(all(b))); 
end

function [b] = testQLMax(testCase)
	b = false;	
	plqf = [inf,1,0,0];
	plqg = [inf,0,0,1];
	result = plq_max(plqf,plqg);
%	x=linspace(-5,5,25)';
%	ymax = plq_eval(result,x);
%  plot2d(x,ymax);
	desired = [-1,1,0,0;1,0,0,1;inf,1,0,0];         
	b = all(result==desired);
assert(all(all(b))); 
end

function [b] = testQLQMax(testCase)
	b = false;
	plqf1 = [-1,1,0,0;1,0,0,1;inf,1,0,0];
	plqf2 = [0,1,0,0;2,0,1,0;inf,1,0,-2];
	result = plq_max(plqf1,plqf2);
  result = plq_clean(result);
%	x=linspace(-5,5,100)';
%  f0=plq_eval(result,x);
%  f1=plq_eval(plqf1,x);
%  f2=plq_eval(plqf2,x);
%  plot2d(x,[f0,f1,f2]);
%  a=gca(); % Handle on axes entity
%  a.thickness=3;
%  poly1= a.children.children(3); %store polyline handle into poly1
%  poly1.foreground = 2; % another way to change the style
%  poly1.thickness = 3;
  desired = [-1,1,0,0;1,0,0,1;inf,1,0,0]; 
	b = all(result==desired);
assert(all(all(b))); 
end

function [b] = testQLQ2Max(testCase)
	b = false;
	plqf1 = [0,0,-2,0;inf,0,2,0];
	plqf2 = [0,0,-1,1;inf,0,1,1];
	result = plq_max(plqf1,plqf2);
  result = plq_clean(result);
%	x=linspace(-5,5,100)';
%  f0=plq_eval(result,x);
%  f1=plq_eval(plqf1,x);
%  f2=plq_eval(plqf2,x);
%  plot2d(x,[f0,f1,f2]);
%  a=gca(); % Handle on axes entity
%  a.thickness=3;
%  poly1= a.children.children(3); %store polyline handle into poly1
%  poly1.foreground = 2; % another way to change the style
%  poly1.thickness = 3;
% 
  desired = [-1,0,-2,0;0,0,-1,1;1,0,1,1;inf,0,2,0]; 
	b = all(result==desired);
assert(all(all(b))); 
end

function [b] = testQQMax(testCase)
	b = false;
	plqf1 = [inf,1,0,0];
	plqf2 = [inf,1/10,0,1];
	result = plq_max(plqf1,plqf2);
%	x=linspace(-5,5,100)';
%  f0=plq_eval(result,x);
%  f1=plq_eval(plqf1,x);
%  f2=plq_eval(plqf2,x);
%  plot2d(x,[f0,f1,f2]);
%  a=gca(); % Handle on axes entity
%  a.thickness=3;
%  poly1= a.children.children(3); %store polyline handle into poly1
%  poly1.foreground = 2; % another way to change the style
%  poly1.thickness = 3;
  desired = [- 1.0540926,1,0,0;1.0540926,0.1,0,1;inf,1,0,0]; 
	b = all(result(:,2:end)==desired(:,2:end));
assert(all(all(b))); 
end


function [b] = testQQMaxdl(testCase)
	b = false;
	plqf1 = [inf,1,0,0];
	plqf2 = [inf,1,2,-1];
	result = plq_max(plqf1,plqf2);
%	x=linspace(-5,5,100)';
%  f0=plq_eval(result,x);
%  f1=plq_eval(plqf1,x);
%  f2=plq_eval(plqf2,x);
%  plot2d(x,[f0,f1,f2]);
%  a=gca(); % Handle on axes entity
%  a.thickness=3;
%  poly1= a.children.children(3); %store polyline handle into poly1
%  poly1.foreground = 2; % another way to change the style
%  poly1.thickness = 3;
  desired = [0.5,1,0,0;inf,1,2,-1]; 
	b = all(result==desired);
assert(all(all(b))); 
end

function [b] = testQQMaxdq1(testCase)
  b = false;
  plqf1 = [inf,1,0,0];
  plqf2 = [inf,-1,2,-1];
  result = plq_max(plqf1, plqf2);

%  x=linspace(-5,5,100)';
%  f0=plq_eval(result,x);
%  f1=plq_eval(plqf1,x);
%  f2=plq_eval(plqf2,x);
%  plot2d(x,[f0,f1,f2]);
%  a=gca(); % Handle on axes entity
%  a.thickness=3;
%  poly1= a.children.children(3); %store polyline handle into poly1
%  poly1.foreground = 2; % another way to change the style
%  poly1.thickness = 3;

  desired = [inf,1,0,0];
  b = isequal(result, desired);
assert(all(all(b))); 
end

function [b] = testQQMaxdq2(testCase)
  b = false;
  plqf1 = [inf,1,0,0];
  plqf2 = [inf,-1,0,0];
  result = plq_max(plqf1, plqf2);

%  x=linspace(-5,5,100)';
%  f0=plq_eval(result,x);
%  f1=plq_eval(plqf1,x);
%  f2=plq_eval(plqf2,x);
%  plot2d(x,[f0,f1,f2]);
%  a=gca(); % Handle on axes entity
%  a.thickness=3;
%  poly1= a.children.children(3); %store polyline handle into poly1
%  poly1.foreground = 2; % another way to change the style
%  poly1.thickness = 3;

  desired = [inf,1,0,0];
  b = isequal(result, desired);
assert(all(all(b))); 
end

function [b] = testQLQMax1(testCase)
	b = false;
	plqf1=[1,1,0,0;3, 0, 2, -1;inf,3,-16,26];
	plqf2=[-1,1,0,0;0,1,0,0;1, 0, 1, 0;inf,3, -4, 2];
	result = plq_max(plqf1,plqf2);
	result = plq_clean(result);
%	x=linspace(-5,5,100)';
%  f0=plq_eval(result,x);
%  f1=plq_eval(plqf1,x);
%  f2=plq_eval(plqf2,x);
%  plot2d(x,[f0,f1,f2]);
%  a=gca(); % Handle on axes entity
%  a.thickness=3;
%  poly1= a.children.children(3); %store polyline handle into poly1
%  poly1.foreground = 2; % another way to change the style
%  poly1.thickness = 3;
  desired = [0,1,0,0;1,0,1,0;inf,3,-4,2]; 
	b = all(result==desired);
assert(all(all(b))); 
end

function [b] = testII1Max(testCase)
	b = false;
	plqf1 = [5,0,0,2];
	plqf2 = [5,0,0,5];
	result = plq_max(plqf1,plqf2);
  desired = [5,0,0,5]; 
	b = all(result==desired);
assert(all(all(b))); 
end

function [b] = testII2Max(testCase)
	b = false;
	plqf1 = [5,0,0,-5];
	plqf2 = [5,0,0,-8];
	result = plq_max(plqf1,plqf2);
	desired = [5,0,0,-5];
	b = all(result==desired);
assert(all(all(b))); 
end

function [b] = testII3Max(testCase)
	b = false;
	plqf1 = [3,0,0,2];
	plqf2 = [5,0,0,5];
	result = plq_max(plqf1,plqf2);
  desired = [inf,0,0,inf]; 
	b = all(result==desired);
assert(all(all(b))); 
end

function [b] = testII4Max(testCase)
	b = false;
	plqf1 = [5,0,0,2];
	plqf2 = [3,0,0,5];
	result = plq_max(plqf1,plqf2);
  desired = [inf,0,0,inf]; 
	b = all(result==desired);
assert(all(all(b))); 
end

function [b] = testQIMax(testCase)
	b = false;
	plqf1 = [inf,1,0,0];
	plqf2 = [2,0,0,5];
	result = plq_max(plqf1,plqf2);
  desired = [2,0,0,5]; 
	b = all(result==desired);
assert(all(all(b))); 
end

function [b] = testIQMax(testCase)
	b = false;
	plqf1 = [2,0,0,5];
	plqf2 = [inf,1,0,0];	
	result = plq_max(plqf1,plqf2);
  desired = [2,0,0,5]; 
	b = all(result==desired);
assert(all(all(b))); 
end

function [b] = testIQ2Max(testCase)
	b = false;
	plqf1 = [2,0,0,3];
	plqf2 = [inf,1,0,0];	
	result = plq_max(plqf1,plqf2);
  desired = [2,0,0,4]; 
	b = all(result==desired);
assert(all(all(b))); 
end

function [b] = testQI2Max(testCase)
	b = false;
	plqf1 = [inf,1,0,0];	
	plqf2 = [2,0,0,3];
	result = plq_max(plqf1,plqf2);
  desired = [2,0,0,4]; 
	b = all(result==desired);
assert(all(all(b))); 
end

function [b] = testQQ_dqBoundsOutside(testCase)
	b = false;
	p1 = [0,1,2,2; inf,0,0,inf];
	p2 = [0,0,0,inf; inf,1,-2,1];
	q1 = plq_lft(p1);
	q2 = plq_lft(p2);
	result = plq_max(q1,q2);
	% Assuming the conjugate is computed correctly.
	expected = [-0.5, 0.25, -1, -1; ...
                    inf, 0.25, 1, 0];
	b = all(result == expected);
assert(all(all(b))); 
end

%TODO More tests for plq_max
%TODO Code Addition function again!

function [b] = runTestFile(testCase)
	b = true;
	b = checkForFail(testWrapper(testLLMax,'testLLMax'), b);
	b = checkForFail(testWrapper(testQLMax,'testQLMax'), b);
	b = checkForFail(testWrapper(testQLQMax,'testQLQMax'), b);
	b = checkForFail(testWrapper(testQLQ2Max,'testQLQ2Max'), b);
	b = checkForFail(testWrapper(testQQMax,'testQQMax'), b);
	b = checkForFail(testWrapper(testQQMaxdl,'testQQMaxdl'), b);
	b = checkForFail(testWrapper(testQQMaxdq1,'testQQMaxdq1'), b);
	b = checkForFail(testWrapper(testQQMaxdq2,'testQQMaxdq2'), b);
	b = checkForFail(testWrapper(testQLQMax1,'testQLQMax1'), b);
	b = checkForFail(testWrapper(testII1Max,'testII1Max'), b);
	b = checkForFail(testWrapper(testII2Max,'testII2Max'), b);
	b = checkForFail(testWrapper(testII3Max,'testII3Max'), b);
	b = checkForFail(testWrapper(testII4Max,'testII4Max'), b);
	b = checkForFail(testWrapper(testQIMax,'testQIMax'), b);
	b = checkForFail(testWrapper(testIQMax,'testIQMax'), b);
	b = checkForFail(testWrapper(testIQ2Max,'testIQ2Max'), b);
	b = checkForFail(testWrapper(testQI2Max,'testQI2Max'), b);
        b = checkForFail(testWrapper(testQQ_dqBoundsOutside,'testQQ_dqBoundsOutside'), b);
assert(all(all(b))); 
end
