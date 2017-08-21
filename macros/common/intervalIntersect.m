function J = intervalIntersect(I1,I2)
  %compute the intersection of 2 intervals
  %I1,I2: intervals stored as a 1x2 matrix: I1=[lb,ub]
  %when ub < lb it means the empty set
  %J: interval J=I1 intersection I2. (may be empty)
  J(1,1)=max(I1(1),I2(1));
  J(1,2)=min(I1(2),I2(2));
end

function b = intervalisempty(I)
  b = I(1)>I(2);
end