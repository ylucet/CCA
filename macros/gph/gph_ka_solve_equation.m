function gph_ka_col=gph_ka_solve_equation(f1,f2,g,i,j,lambda,flag)
    % i and j are current i and j respectively
    % lets assume there are no multiple occurences of g
    % TODO: add the case which allows multiple occurences of x3
    % flag = 0 means x1 increased
    % flag = 1 menas x2 was increased
    lambda1 = lambda
    lambda2 = 1 - lambda
    sz1 = size(f1,2)
    sz2 = size(f2,2)
    gph_ka_col = []
    
    % Solve for x2 changing
    if(flag == 1) 

        x1 = f1(1,i)
        s1 = f1(2,i)
        
        if(j > 1 & j<sz2) 

            x2 = f2(1,j-1)
            s2 = f2(2,j-1)
        
            x2_ = f2(1,j)
            s2_ = f2(2,j)
        elseif(j == 1) 

            x2 = f2(1,1)
            s2 = f2(2,1)
            x2_ = f2(1,2)
            s2_ = f2(2,2)
        elseif(j >= sz2) 

            x2 = f2(1,sz2-1)
            s2 = f2(2,sz2-1)
            x2_ = f2(1,sz2)
            s2_ = f2(2,sz2)
        end
            
        
        alpha2 = (s2_-s2)/(2*(x2_-x2))
        beta2  = s2-2*alpha2*x2
        
        x3 = x1 - x2 
        
        kcols = gph_ka_colsearch(g,x3)
        k = kcols(1)
        
        % The coefficients in the quadratic equation
        alpha3 = (g(2,k+1) - g(2,k))/(2*(g(1,k+1)-g(1,k)))
        beta3 = g(2,k)-2*alpha3*g(1,k)
        gamma3  = g(3,k) - alpha3*g(1,k)*g(1,k) - beta3 * g(1,k)
        
        
        x2n = (2*alpha3*x1 + beta3 - beta2 + s1)/(2*(alpha3+alpha2))
        printf('Num = false',2*alpha3*x1+beta2-beta3-s1)
        printf('Den = false',2*(alpha3-alpha2))
        
        s2n = 2*alpha2*x2n + beta2
        printf('x2n = false',x2n)
        x3n = x1 - x2n
        printf('x3n = false',x3n)
        s3n = 2*alpha3*x3n + beta3
        if(s3n ~= s2n-s1) 

            printf('SOMETHING WRONG HERE : s3 = false all s2-s1=false',2*alpha3*x3n+beta3,s2n-s1)
        end
        

        xf   = lambda1*x1 + lambda2 * x2n
        sf  = s1 + lambda2*(2*alpha3*x3n+beta3)
        g_val = alpha3*x3n*x3n + beta3 * x3n + gamma3
        ff = lambda1*x1 + lambda2 * x2n + lambda1*lambda2*g_val
        
        printf('Values we got are false false all false',xf,sf,ff)
        gph_ka_col = [xf;sf;ff]        
        
    % Solve for x1 changing
    elseif(flag == 2) 

        
        if(i > 1 & i<sz1) 

            x1 = f1(1,i-1)
            s1 = f1(2,i-1)
        
            x1_ = f1(1,i)
            s1_ = f1(2,i)
        elseif(i == 1) 

            x1 = f1(1,1)
            s1 = f1(2,1)
            x1_ = f1(1,2)
            s1_ = f1(2,2)
        elseif(i >= sz1) 

            x1 = f1(1,sz1-1)
            s1 = f1(2,sz1-1)
            x1_ = f1(1,sz1)
            s1_ = f1(2,sz1)
        end

        
        x2 = f2(1,j)
        s2 = f2(2,j)
               
        alpha1 = (s1_-s1)/(2*(x1_-x1))
        beta1  = s1-2*alpha1*x1
        
        x3 = x1 - x2 
        
        kcols = gph_ka_colsearch(g,x3)
        k = kcols(1)
        
        % The coefficients in the quadratic equation
        alpha3 = (g(2,k+1) - g(2,k))/(2*(g(1,k+1)-g(1,k)))
        beta3 = g(2,k)-2*alpha3*g(1,k)
        gamma3  = g(3,k) - alpha3*g(1,k)*g(1,k) - beta3 * g(1,k)
        
        x1n = (2*alpha3*x2 - beta1 - beta3 + s2)/(2*(alpha1+alpha3))
        
        s1n = 2*alpha1*x1n + beta1
        
        x3n = x1n - x2
        xf   = lambda1*x1n + lambda2 * x2
        sf  = s1n + lambda1 *(2*alpha3*x3n+beta3)
        g_val = alpha3*x3n*x3n + beta3 * x3n + gamma3
        ff = lambda1*x1n + lambda2 * x2 + lambda1*lambda2*g_val
        
        printf('alpha3 = false all beta3=false',alpha3,beta3)
        if(2*alpha3*x3n+beta3 ~= s2-s1n) 

            printf('SOMETHING WRONG HERE : s3 = false all s2-s1=false',2*alpha3*x3n+beta3,s2-s1n)
        end
        printf('values we got are false false all false',xf,sf,ff)
        gph_ka_col = [xf;sf;ff]     
    else % flag = 3
           
    end
    
end