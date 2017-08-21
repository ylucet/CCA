function out=rowMap(func,m)
  % Map a function to each of the rows of a matrix, putting the resulting row vectors into the output matrix
  % @param func A function that takes two parameters (the first is a row vector,
  %        the second the number of the current row) and returns a row vector

  out=[]
  s=size(m)
  n=s(1)
  for i=1:n
    out(i,:)=func(m(i,:),i)
  end
end