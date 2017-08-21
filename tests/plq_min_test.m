function tests = plq_min_test()
tests = functiontests(localfunctions);
end
% Author:   Mike Trienis
% For:      Dr. Yves Lucet
% Whatsit:  A test file for plq_max, adds two piecewise linear quadratic functions. 


%L: Linear, Q: Quadratic, I: Indicator, PW: Piecewise


function [b] = testLLMin(testCase)
	b = false;	
	plqf = [inf,0,1,0];
	plqg = [inf,0,-1,0];
	[result,maxf] = plq_min(plqf,plqg);
%	x=linspace(-5,5,25)';
%	ymax = plq_eval(result,x);
%  plot2d(x,ymax);
	desired = [0,0,1,0;inf,0,-1,0];          
	b = isequal(result, desired);
	b = b & isequal(maxf, [1,-inf,0;2,0,inf]);
assert(all(all(b))); 
end

function [b] = testQLMax(testCase)
	b = false;	
	plqf = [inf,1,0,0];
	plqg = [inf,0,0,1];
	result = plq_min(plqf,plqg);
%	x=linspace(-5,5,25)';
%	ymax = plq_eval(result,x);
%  plot2d(x,ymax);
	desired = [-1,0,0,1;1,1,0,0;inf,0,0,1];         
	b = isequal(result,desired);
assert(all(all(b))); 
end

function [b] = testQLQMax(testCase)
	b = false;
	plqf = [-1,1,0,0;1,0,0,1;inf,1,0,0];
	plqg = [0,1,0,0;2,0,1,0;inf,1,0,-2];
	result = plq_min(plqf,plqg);
  result_clean = plq_clean(result);
%	x=linspace(-5,5,100)';
%	yf = plq_eval(plqf,x);
%	yg = plq_eval(plqg,x);
% plot2d(x,[yf,yg],rect=[-2,-1,2,5]);

  desired = [0,1,0,0;2,0,1,0;inf,1,0,-2]; 
	b = isequal(result_clean,desired);
assert(all(all(b))); 
end

function [b] = testQQMax(testCase)
	b = false;
	plqf1 = [inf,1,0,0];
	plqf2 = [inf,1/10,0,1];
	result = plq_min(plqf1,plqf2);
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

  desired = [- 1.0540926,0.1,0,1;1.0540926,1,0,0;inf,0.1,0,1]; 
	b = isequal(result(:,2:end),desired(:,2:end));
assert(all(all(b))); 
end

function [b] = testQQMaxdl(testCase)
	b = false;
	plqf1 = [inf,1,0,0];
	plqf2 = [inf,1,2,-1];
	result = plq_min(plqf1,plqf2);
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
    desired = [0.5,1,2,-1;inf,1,0,0]; 
	b = isequal(result,desired);
assert(all(all(b))); 
end

