function tests = plq_lft_test()
tests = functiontests(localfunctions);
end
% Author:   Mike Trienis
% For:      Dr. Yves Lucet
% Whatsit:  A test file for plq


%L: Linear, Q: Quadratic, I: Indicator


function [b] = testLLNonsmooth(testCase)
	b = false;
	plqf = [ -1, 0, -1, -1; inf, 0, 1, 1];
	result = plq_lft(plqf);
	result2 = mikeplq_lft(plqf);
	desired = [-1, 0, 0, inf; 1, 0, -1, 0; inf, 0, 0, inf];          
	b = all(result==desired);
    assert(all(all(b)));
end


function [b] = testQQSmooth(testCase)
	b = false;
	plqf = [-2,1,1,1;inf,1,1,1];
	result= plq_lft(plqf);
	result2 = mikeplq_lft(plqf);
	%desired = [-3, 1/4, -1/2, -3/4; inf, 1/4, -1/2, -3/4];  
	desired = [inf, 1/4, -1/2, -3/4];
	b = all(result==desired);
	if (~b) 
 return;  
	end;
	b = all(result2==desired);
assert(all(all(b)));
end

function [b] = testQQQSmooth(testCase)
	b = false;
	plqf = [-2,1,1,1;2,1,1,1;inf,1,1,1];
	result= plq_lft(plqf);
	result2 = mikeplq_lft(plqf);
	%desired = [-3, 1/4, -1/2, -3/4; 5, 1/4, -1/2, -3/4; inf,1/4,-1/2,-3/4];
	desired = [inf,1/4,-1/2,-3/4];
	b = all(result==desired);
	if (~b) 
 return;  
	end;
	b = all(result2==desired);
assert(all(all(b)));
end

function [b] = testabs(testCase)
	b = false;
	plqf = [0,0,-1,0;inf,0,1,0];%abs
	result= plq_lft(plqf);
	result2 = mikeplq_lft(plqf);
	desired = [-1, 0, 0, inf; 1, 0, 0, 0; inf, 0, 0, inf];          
	b = all(result==desired);
	if (~b) 
 return;  
	end;
	b = all(result2==desired);
assert(all(all(b)));
end

function [b] = testL(testCase)
	b = false;
	plqf=[inf,0,1,1];
	result= plq_lft(plqf);
	result2 = mikeplq_lft(plqf);
	desired = [1, 0, 0, -1];          
	b = all(result==desired);
	if (~b) 
 return;  
	end;
	b = all(result2==desired);
assert(all(all(b)));
end

function [b] = testI(testCase)
	b = false;
	plqf=[1,0,0,-1];
	result= plq_lft(plqf);
	result2 = mikeplq_lft(plqf);
	desired = [inf, 0, 1, 1];          
	b = all(result==desired);
	if (~b) 
 return;  
	end;
	b = all(result2==desired);
assert(all(all(b)));
end

function [b] = testI2(testCase)
	b = false;
	plqf=[1,0,0,-1];
	result= plq_lft(plqf);
	result2 = mikeplq_lft(plqf);
	desired = [inf, 0, 1, 1];          
	b = all(result==desired);
	if (~b) 
 return;  
	end;
	b = all(result2==desired);
assert(all(all(b)));
end


function [b] = testNormSquared(testCase)
	b = false;
	plqf=[inf,1/2,0,0];
	result= plq_lft(plqf);
	result2 = mikeplq_lft(plqf);
	desired = [inf, 1/2, 0, 0];          
	b = all(result==desired);
	if (~b) 
 return;  
	end;
	b = all(result2==desired);
assert(all(all(b)));
end	

function [b] = testQQNonsmooth(testCase)
	b = false;
	plqf=[0,1,0,0;inf,2,0,0];
	result= plq_lft(plqf);
	result2 = mikeplq_lft(plqf);
	desired = [0 , 1/4, 0, 0; inf, 1/8, 0, 0];          
	b = all(result==desired);
	if (~b) 
 return;  
	end;
	b = all(result2==desired);
assert(all(all(b)));
end	

function [b] = testQLQSmooth(testCase)
	b = false;
	plqf=[1,1,0,0;3, 0, 2, -1;inf,3,-16,26];
	result= plq_lft(plqf);
	result2 = mikeplq_lft(plqf);
	s=result(:,1);sa=result(:,2);sb=result(:,3);sc=result(:,4);
	resultLHS = [s];
	result2LHS = result2(:,1);
	desiredLHS = [2; inf];
	resultRHS = [sa, sb, sc];
	result2RHS = result2(:,2:4);
	desiredRHS =[1/4, 0, 0; 1/12, 8/3, -14/3];
	b = all((resultLHS==desiredLHS) & (norm(resultRHS - desiredRHS)<1E-8));
assert(all(all(b)));
end	


function [b] = testQLQNonsmooth(testCase)
	b = false;
	plqf=[0,1,0,0;1, 0, 1, 0;inf,3, -4, 2];
	result= plq_lft(plqf);
	result2 = mikeplq_lft(plqf);
	s=result(:,1);sa=result(:,2);sb=result(:,3);sc=result(:,4);
	resultLHS = [s];
	result2LHS = result2(:,1);
	desiredLHS = [0; 1; 2; inf];
	resultRHS = [sa, sb, sc];
	result2RHS = result(:,2:4);
	desiredRHS =[1/4, 0, 0; 0, 0, 0; 0,1,-1;1/12,2/3,-2/3];
	b = all((resultLHS==desiredLHS) & (norm(resultRHS - desiredRHS)<1E-8));
assert(all(all(b)));
end	


function [b] = testPLQboundedLHS(testCase)
	b = false;
	plqf=[-5,0,0,inf;inf,1,0,5];
	desired = [-10, 0, -5, -30;inf,1/4,0,-5];          
	result= plq_lft(plqf);
	result2 = mikeplq_lft(plqf);
	b = all(result==desired);
	if (~b) 
 return;  
	end;
	b = all(result2==desired);
assert(all(all(b)));
end	

function [b] = testPLQboundedRHS(testCase)
	b = false;
	plqf=[-5,1,0,5;inf,0,0,inf];
	desired = [-10, 1/4, 0, -5;inf,0,-5,-30];          
	result= plq_lft(plqf);
	result2 = mikeplq_lft(plqf);
	b = all(result==desired);
	if (~b) 
 return;  
	end;
	b = all(result2==desired);
assert(all(all(b)));
end	

function [b] = testPiecewiseLinear(testCase)
	b = false;
	plqf=plq_build(linspace(-2,2,10),@exp,@exp,false);
	result= plq_lft(plqf);
	desired = mikeplq_lft(plqf);
	b = all(result==desired);
assert(all(all(b)));
end	

function [b] = testNonconvex(testCase)
	b = false;
	plqf=[-1,0,-1,-1;0,0,1,1;1,0,-1,1;inf,0,1,-1];
	result= plq_lft(plqf,false);
	desired = [-1,0,0,inf;0,0,-1,0;1,0,1,0;inf,0,0,inf];
	b = all(result==desired);
assert(all(all(b)));
end	

function [b]= testNonconvexSingleInputParameter(testCase)
    function y=fct(x),y=(x.^2-1).^2;end
    function y=dfct(x),y=4*x.*(x.^2-1);end
    x=linspace(-3,3,5);x=[x 0 -1 1];
    x=unique(sort(x, 'descend'));
    f=plq_build(x,@fct);
    fsdirect=plq_lft(f);
    b=plq_check(fsdirect);
assert(all(all(b)));
end