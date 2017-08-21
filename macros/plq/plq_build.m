function plqf = plq_build(x,f,df,needEval,exclude,method,extrapolate)
%PLQ function = piecewise linear going through (x,f(x)) with derivative
%df(x) at (x,f(x)) i.e. 1st order approximation of f  
%needEval==%evaluate point by point
%exclude: ??
%method: "plq"  normal PLQ approximation
%        "soqs" Shape-Preserving Osculatory Quadratic Spline approximation
%extrapolate: 'constant' or 'bounded' to extend outside of domain by constant or inf
%NOTE: feval(x,exp) returns an error, but function
%y=f(x),y=exp(x);endfunction;feval(x,f) works
  
  if (nargin < 3) 
 df = false; dy = false;  
  end;
  if (nargin < 4) 
 needEval = false;  
  end;  % Assume function is vectorized.
  if (nargin < 5) 
 exclude = false;  
  end;
  if (nargin < 6) 
 method = 'plq';  
  end;
  if (nargin < 7) 
 extrapolate = 'constant';  
  end;
   
  if size(x,1) < size(x,2) 
 x=x';  
  end;
  dfType = class(df);
%    mprintf(" dfType Completed! ")
%    disp(dfType)
  if (needEval) 

    try, y=feval(x,f);
    catch, y=f(x);  
    end;
    if (isequal(dfType, 'function_handle') | isequal(dfType,'fptr') | df )

      try, dy=feval(x,df);
      catch, dy=df(x);  
      end;
    else
      dy = false;
    end;
  else
    try, y=f(x);
    catch, y=feval(x,f);
    end;
    if (isequal(dfType, 'function_handle') | isequal(dfType,'fptr') | df ) 

        
      try, dy=df(x);
      catch, dy=feval(x,df);  
      end;
    else
      dy = false;
    end;
  end;

  if isequal(method, 'soqs') 

    if (dy==false) 

      dy = soqs_slopes(x,y);
    end;
    plqf = soqs_build(x,y,dy,extrapolate);
  else%anything else default to 'plq'
    plqf = plq_build_d(x,y,dy,exclude);
  end;
end

