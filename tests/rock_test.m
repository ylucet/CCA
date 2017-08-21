function tests = rock_test()
tests = functiontests(localfunctions);
end


% Author: Bryan Gardiner
% For: Yves Lucet
% Date: Summer 2008


function b = testRockBasic1(testCase)
  b = false;
  a = [1,2,4,5];
  bm = [-5,-3,-1,10];
  bp = [-3,-2, 1,20];
  B = [a;bm;bp];
  Rexp(:,:,1) = [1,0,-5,5;2,0,-3,3;4,0,-2,1;5,0,1,-11;inf,0,20,-106];
  Rexp(:,:,2) = [1,0,-5,8;2,0,-3,6;4,0,-2,4;5,0,1,-8;inf,0,20,-103];
  Rexp(:,:,3) = [1,0,-5,10;2,0,-3,8;4,0,-1,4;5,0,1,-4;inf,0,20,-99];
  Rexp(:,:,4) = [1,0,-5,0;2,0,-3,-2;4,0,-1,-6;5,0,10,-50;inf,0,20,-100];
  for k = 1:4
    R(:,:,k) = plq_rock(B, k);
  end;
  b = isequal(Rexp, R);
end

function b = testRockDecrA(testCase)
  %exec("../loader.sce");
  b = false;
  a =  [  1,  3, 7, 15];
  bm = [-11,-10,-5,- 2];
  bp = [-10,- 5,-3,- 1];
  B = [a;bm;bp];
  R0 = plq_rock(B, 2);
  R1 = plq_rock(B(:,end:-1:1), 2);
  b = isequal(R0, R1);
end

function testPlqRockNonIncrA(testCase)
  a  = [1,2,2,3];
  bl = [1,3,5,7];
  br = [2,4,6,8];
  A = [a;bl;br];
  %%plq_rock(A, 4);
end