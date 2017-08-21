function tests = plq_proj_test()
tests = functiontests(localfunctions);
end
% Author:   	Yves Lucet
% Whatsit:  	Test file for plq_proj




function [b] = testProj(testCase)
  b = false;
  if (exist('quapro')) 

      n=200;
      x=linspace(-2,2,n)';f=abs(abs(x)-1);
      [plqr,fr]=plq_proj(f,x,2);
      pr=plq_eval(plqr,x);
      %result validated symbolically with Maple
      plqd = [-sqrt(2),0,-1,-1;sqrt(2),0,0,sqrt(2)-1;inf,0,1,-1];
      pd=plq_eval(plqd,x);
      fd = 4 - 8*sqrt(2)/3;
      b = all(norm(pr-pd)<1E-4) & abs(fr-fd)<1E-4;
  else
      b = true;
  end;
assert(b) 
end

function b=testProjNormTooHigh(testCase)
  %need to finish the test!
    b=true;
    if (exist('quapro')) 

      n = 200;
      x = linspace(-2, 2, n)';
      f = abs(abs(x) - 1);
      [plqr, fr] = plq_proj(f, x, 3);
    else
      %%cerror('Quapro not installed! Install it to call plq_proj');  
    end;
assert(b) 
end

function [b] = runTestFile(testCase)
	b = true;
	b = checkForFail(testWrapper(testProj, 'testProj'), b);
	b = checkForFail(errorTestWrapper(testProjNormTooHigh, 'testProjNormTooHigh'), b);
assert(b) 
end
