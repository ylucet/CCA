function [b,s] = checksize(n,m,sizef,functionname)
  %assume n,m positive integer, and test whether sizef=[n,m]
  
  b = n==sizef(1) & m==sizef(2);s='';
  if ~b
    if n~=sizef(1)
      s=sprintf('Inconsistent size of f in ;')
    end
    if m~=sizef(2)
      s=sprintf('Inconsistent size of f in ;')
    end
  end;
end