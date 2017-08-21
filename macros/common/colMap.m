% Map a function to each of the columns of a matrix, putting the resulting column vectors into the output matrix
% @param func A function that takes two parameters (the first is a column vector,
%        the second the number of the current column) and returns a column vector
function out=colMap(func,m)
  out=[]
  s=size(m)
  n=s(2)
  for i=1:n
    out(:,i)=func(m(:,i),i)
  end
end