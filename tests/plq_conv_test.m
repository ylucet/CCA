function tests = plq_conv_test()
tests = functiontests(localfunctions);
end
% Author:   Mike Trienis
% For:      Dr. Yves Lucet
% Whatsit:  A test file for plq


%L: Linear, Q: Quadratic, I: Indicator


function b = testInfconvLft(testCase)
  b = false;
  plqf = [inf,1/4,0,0];
  plqg = [inf,1,0,0];
  result = plq_infconv_lft(plqf,plqg);
  desired = [inf,1/5,0,0];
  b = all(result==desired);
assert(b);
end

function b = testDeconvLft(testCase)
  b = false;
  plqf = [inf,1/4,0,0];
  plqg = [inf,1,0,0];
  result = plq_deconv_lft(plqf,plqg);
  desired = [inf,1/3,0,0];
  b = all(result==desired);
assert(b); 
end

function b = testInfconvBruteDL1(testCase)
  b = false;
  f = [-1,0,0,inf;1,0,-1,0;inf,0,0,inf];
  g = [-1,0,0,inf;1,0,1,0;inf,0,0,inf];
  desired = plq_infconv_lft(f, g);
  [result1, lb1] = plq_infconv_brute_d(f(2,:), g(2,:), [-1;-1], [1;1]);
  [result2, lb2] = plq_infconv_brute_d(g(2,:), f(2,:), [-1;-1], [1;1]);
  result1 = [lb1,0,0,inf;result1;inf,0,0,inf];
  result2 = [lb2,0,0,inf;result2;inf,0,0,inf];
  b = isequal(desired, result1, result2);
assert(b); 
end

function b = testInfconvBruteDL2(testCase)
  b = false;
  f = [-0.5,0,0,inf;1.5,0,-1,0.5;inf,0,0,inf];
  g = [-1,0,0,inf;1,0,1,0;inf,0,0,inf];
  desired = plq_infconv_lft(f, g);
  [result1, lb1] = plq_infconv_brute_d(f(2,:), g(2,:), [-0.5;-1], [1.5;1]);
  [result2, lb2] = plq_infconv_brute_d(g(2,:), f(2,:), [-1;-0.5], [1;1.5]);
  result1 = [lb1,0,0,inf;result1;inf,0,0,inf];
  result2 = [lb2,0,0,inf;result2;inf,0,0,inf];
  b = isequal(desired, result1, result2);
assert(b);
end

function b = testInfconvBruteDL3(testCase)
  b = false;
  f = [-1,0,0,inf;1,0,-1,0;inf,0,0,inf];
  g = [2,0,0,inf;4,0,1,-3;inf,0,0,inf];
  desired = plq_infconv_lft(f, g);
  [result1, lb1] = plq_infconv_brute_d(f(2,:), g(2,:), [-1;2], [1;4]);
  [result2, lb2] = plq_infconv_brute_d(g(2,:), f(2,:), [2;-1], [4;1]);
  result1 = [lb1,0,0,inf;result1;inf,0,0,inf];
  result2 = [lb2,0,0,inf;result2;inf,0,0,inf];
  b = isequal(desired, result1, result2);
assert(b);
end

function b = testInfconvBruteL0(testCase)
  % nf==1, ng==1, f up, g up.
  b = false;
  f = [-1,0,0,inf;1,0,1,0;inf,0,0,inf];
  g = [0,0,0,inf;2,0,2,-1/2;inf,0,0,inf];
  desired = plq_infconv_lft(f, g);
  [result1, am1] = plq_infconv_brute(f, g);
  [result2, am2] = plq_infconv_brute(g, f);
  b = isequal(desired, result1, result2);
  %b = b & isEqual(am1, am2),
assert(b);
end

function b = testInfconvBruteL1(testCase)
  % nf==2, ng==1, f v, g up.
  b = false;
  f = [-1,0,0,inf;1,0,-1,0;3,0,1,-2;inf,0,0,inf];
  g = [-1,0,0,inf;1,0,1,0;inf,0,0,inf];
  desired = plq_infconv_lft(f, g);
  [result1, am1] = plq_infconv_brute(f, g);
  [result2, am2] = plq_infconv_brute(g, f);
  b = isequal(desired, result1, result2);
  %b = b & isEqual(am1, am2),
assert(b); 
end

function b = testInfconvBruteL2(testCase)
  % nf==2, ng==2, f v, g v.
  b = false;
  f = [-1,0,0,inf;1,0,-1,0;3,0,1,-2;inf,0,0,inf];
  g = [-3,0,0,inf;-1,0,-1,-1;1,0,1,1;inf,0,0,inf];
  desired = plq_infconv_lft(f, g);
  [result1, am1] = plq_infconv_brute(f, g);
  [result2, am2] = plq_infconv_brute(g, f);
  b = isequal(desired, result1, result2);
  %b = b & isEqual(am1, am2),
assert(b);
end

function b = testInfconvBruteL3(testCase)
  % nf==3, ng==3, f u, g down, disjoint domains.
  b = false;
  f = [-4,0,0,inf;-3,0,-1,-2;-2,0,0,1;-1,0,1,3;inf,0,0,inf];
  g = [0,0,0,inf;1,0,-5,8;2,0,-2,5;3,0,-1/2,2;inf,0,0,inf];
  desired = plq_infconv_lft(f, g);
  [result1,am1] = plq_infconv_brute(f, g);
  [result2,am2] = plq_infconv_brute(g, f);
  b = isequal(desired, result1, result2);
  %b = b & isEqual(am1, am2);
assert(b);
end

function plqf = plq_pl_from(x0, y0, dx, ms)
  if (size(ms, 1) > size(ms, 2)) 
 ms = ms';  
  end;
  plqf = zeros(length(ms) + 2, 4);
  x = x0;
  y = y0;
  plqf(1,:) = [x0, 0, 0, inf];
  i = 2;
  for m = ms
    plqf(i,:) = [x + dx, 0, m, y - m*x];
    x = x + dx;
    y = plqf(i,3)*x + plqf(i,4);
    i = i + 1;
  end;
  plqf(end,:) = [inf, 0, 0, inf];
end

function b = testInfconvBruteL4(testCase)
  b = false;
  %f = [0,0,0,inf;2,0,0,1;3,0,0,0;6,0,0,1;inf,0,0,inf];
  f = [0.5,0,0,inf;1.5,0,-1,1.5;2.5,0,0,0;5,0,0.4,-1;inf,0,0,inf];
  g = [0,0,0,inf;1,0,-1,2;3,0,1,0;inf,0,0,inf];
  desired = plq_infconv_lft(f, g);
  [result1, am1] = plq_infconv_brute(f, g);
  [result2, am2] = plq_infconv_brute(g, f);
  b = (desired == result1 | abs(desired - result1) < 1E-6);
  b = b &  (desired == result2 | abs(desired - result2) < 1E-6);
  assert(all(all(b)));
  %b = b & isEqual(am1, am2);
end

function b = testInfconvBruteLCommut1(testCase)
  b = false;
  f = plq_pl_from(0, 0, 1, 1:4);
  g = plq_pl_from(0.1, -2, 0.3, 1:8);
  desired = plq_infconv_lft(f, g);
  [result1, am1] = plq_infconv_brute(f, g);
  [result2, am2] = plq_infconv_brute(g, f);
  b = (desired == result1 | abs(desired - result1) < 1E-6);
  b = b &  (desired == result2 | abs(desired - result2) < 1E-6);
  assert(all(all(b)));
  %b = b & isEqual(am1, am2);
end