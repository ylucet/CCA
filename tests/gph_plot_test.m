function tests = gph_plot_test()
tests = functiontests(localfunctions);
end
% Unit test file for _gph_plotbounds

function [b] = testPass1(testCase)
	fabs=[-1 0 0 1 ; -1 -1 1 1; 1 0 0 1 ];
    L{1} = fabs;
	rect = gph_plotbounds(L);	
	b = all(rect==[-1.2,-1.2,1.2,1.2]);
   assert(all(all(b)));
end

function [b] = testPass2(testCase)
	fabs=[-1 0 0 1 ; -1 -1 1 1; 1 0 0 1 ];
	g=[-2 -1 -1 1 1 2; -1 -1 0 0 1 1; 1 0 0 0 0 1];
    L{1} = fabs; L{2} = g;
	rect = gph_plotbounds(L);	
	b = all(rect==[-2.4,-1.2,2.4,1.2]);
assert(all(all(b)));
end

function [b] = testPass2a(testCase)
  h1=[-1 0 0 1; -2 -2 2 2;2 0 0 2];%2*abs
  h2=[-3 -2 -2 0 0 0.5;-1 -1 0 0 1 1;1 0 0 0 0 1];
  L{1} = h1; L{2} = h2;
	rect = gph_plotbounds(L);
	b = all(rect==[-3.4,-2.4,1.4,2.4]);
assert(all(all(b)));
end

function [b] = testPass1_gph_yCoord(testCase)
  y = gph_yCoord(-2,0,-1,1,-1);%horizontal line
	b = (y == -1);
	y = gph_yCoord(-2,0,-1,1,0);%angled line
	b = b & (y==-3);
	y = gph_yCoord(-1,0,0,0,1);
	b = b & (y==-inf);
	y = gph_yCoord(0,0,-1,1,0);%angled line
	b = b & (y==-1);	
assert(all(all(b)));
end

function [b] = testPass1_gph_extendGph(testCase)
  fabs=[-1 0 0 1 ; -1 -1 1 1; 1 0 0 1 ];
  L{1} = fabs;
  rect = gph_plotbounds(L);
  b=all(rect==[-1.2,-1.2,1.2,1.2]);
  G=gph_extendGph(fabs,rect);
  b = b & all(G==[-1.2 -1 0 0 1 1.2;-1 -1 -1 1 1 1]);
  assert(all(all(b)));
end

function [b] = testPass2_gph_extendGph(testCase)
  f=[-1 -1 1 1;-1 0 0 1;0 0 0 0];
  L{1} = f;
  rect = gph_plotbounds(L);
  b=all(rect==[-1.2,-1.2,1.2,1.2]);
  G=gph_extendGph(f,rect);
  b = b & all(G==[-1 -1 -1 1 1 1;-1.2 -1 0 0 1 1.2]);
end

%disable plotting
%function [b] = testPass_gph_plot()
%  fabs=[-1 0 0 1 ; -1 -1 1 1; 1 0 0 1 ];
%  while (winsid() ~= []); xdel(); end;
%  clf();gph_plot(fabs);
%  while (winsid() ~= []); xdel(); end;
%  return %endfunction

