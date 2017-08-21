%%%%%%%%%PLQ CONJUGATE HELPER FUNCTION%%%%%%%%%%%%%
function plqType=getType(n,x,a,b,c,i)
    if a(i) == 0 

        plqType = 1;%part is linear
    else plqType = 2;%part is quadratic
    end
    
    if n == 1 & x(i) == inf & a(i) == 0 

        plqType = 3;%LINE - TO - POINT
    elseif n == 1 & x(i) < inf 
 %POINT - TO - LINE
       plqType = 4;
    end
    
    if a(i) == inf | b(i) == inf | c(i) == inf & i == 1 
 
      plqType  = 5; %Bounded by the LHS
    end
    
    if a(i) == inf | b(i) == inf | c(i) == inf & i == size(x,1) 
 
      plqType  = 6; %Bounded by the RHS
    end
end
%%%%%%%%%PLQ CONJUGATE HELPER FUNCTION%%%%%%%%%%%%%