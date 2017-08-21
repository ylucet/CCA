% The actual ka calculating function
% All matrices in GPH form and the output also is in GPH form
% We need 5 parameters, representations are quite obvious
% For notation sake, f3 = g here as mentioned in the paper
% Return value ka is the GPH matrix of the kernel average
% Note : The GPH matrix will have an even number of columns always
% TODO : Write unit tests for all subcases
function ka = gph_ka(f1,f2,f3,lambda)
    printf('f1 is ')
    disp(f1)
    printf('f2 is ')
    disp(f2)
    printf('f3 is ')
    disp(f3)
    % First of all lets check if its proper
    t = gph_ka_isProper(f1,f2,f3,lambda)
    lambda1 = lambda
    lambda2 = 1-lambda
    ka = []
    if(t == false) 

        printf('The KA is not proper. Hence not calculating')
        return;
    end 
    sz1 = size(f1,2)
    sz2 = size(f2,2)
    sz3 = size(f3,2)
    
    % The ka matrix in GPH form to be returned
    ka = [] 
    
    % Iterating over x1 first
    i = 1
    j = 1 % is the index in f2
    k = 1
    
    while i<=sz1
        x1 = f1(1,i)
        s1 = f1(2,i)
        
        if(j <= sz2) 

            x2 = f2(1,j)
            s2 = f2(2,j)
        else 
            % TODO
            % 1. find_values should not be called if the function
            % is bounded
            % 2. Increment amount should be changed to the previous diff.
            x2  = x2 + 1 % right now just incrementing it by 1
            [s2,y2] = find_values(f2,sz2-1,x2)  
        end
        
        
        x3 = x1-x2
		kcols = gph_ka_colsearch(f3,x3)
        % kcols can be of maximum size 2
        sz_k = size(kcols,2)
        % size being 2 means that the intervals share the point
        if(sz_k == 2) 

            printf('Size of kcols is 2')
            k1 = kcols(1)
            k2 = kcols(2)
            s3_1 = f3(2,k1)
            s3_2 = f3(2,k2)
            if(s3_1 < s2-s1) 

                % check for s3_2 if its still lesser
                if(s3_2 < s2-s1) 

                    % lets increase x1 and see if its greater or equal
                    i = i + 1;                                  
                elseif(s3_2 == s2-s1) 

                    % record and move on
                    printf('Found a point. Include record code here')
                    i = i + 1;
                else
                    i = i + 1;
                    printf('s3_2 < s2-s1')
                end
            elseif(s3_1 == s2-s1) 

                % record and increase x1
                printf('Found a point2. Include record code here')    
            else % s3_1 > s2-s1
               % going to s3_2 would not help at all as s3 would just inc.
                if(s3_2 < s2-s1) 

                printf('Error with gph reshape of f3')
                end
                j = j + 1;
            end           

        elseif(sz_k == 1) 

            % Primary stuff, one piece quadratics should work with this
            k = kcols(1)
            [s3, y3] = find_values(f3,k,x3)
            if(s1 < s2-s3) 

                printf('Lesser than case')
                % We always solve for x2
                add_column = gph_ka_solve_equation(f1,f2,f3,i,j,lambda,1)
                ka  = [ka add_column]
                i = i + 1;
            elseif(s1 == s2-s3) 
    
                x_val = lambda1 * x1 + lambda2*x2
                f_val = lambda1 * x1 + lambda2 * x2 + lambda1*lambda2*y3
                s_val = s2 - s1
                
                col_add = [x_val;f_val;s_val]
                ka = [ka col_add] 
                % Increase x1 - since equality
                i = i + 1;
            else 
                printf('Greater than')
                if(j <= sz2)
                    j = j + 1;
                end
            end
        else
            printf('Error: Too many/less values for x3: Not possible')
            printf('Error with the code/proof');
        end
    end
    
    % Iterating over x2 now
    i = 1
    j = 1
    k = 1
    
    while j<=sz2
        x2 = f2(1,j)
        s2 = f2(2,j)
        
        if(i <= sz1) 

            x1 = f1(1,i)
            s1 = f1(2,i)
        else 
            % TODO
            % 1. find_values should not be called if the function
            % is bounded
            % 2. Increment amount should be changed to the previous diff.
            x1  = x1 + 1 % right now just incrementing it by 1
            [s1,y1] = find_values(f1,sz1-1,x1)  
        end
        
        
        x3 = x1-x2
        kcols = gph_ka_colsearch(f3,x3)
        % kcols can be of maximum size 2
        sz_k = size(kcols,2)
        % size being 2 means that the intervals share the point
        if(sz_k == 2) 

            printf('Size of kcols is 2')
            k1 = kcols(1)
            k2 = kcols(2)
            s3_1 = f3(2,k1)
            s3_2 = f3(2,k2)
            if(s3_1 < s2-s1) 

                % check for s3_2 if its still lesser
                if(s3_2 < s2-s1) 

                    % lets increase x1 and see if its greater or equal
                    i = i + 1;                                  
                elseif(s3_2 == s2-s1) 

                    % record and move on
                    printf('Found a point. Include record code here')
                    i = i + 1;
                else
                    i = i + 1;
                    printf('s3_2 < s2-s1')
                end
            elseif(s3_1 == s2-s1) 

                % record and increase x1
                printf('Found a point2. Include record code here')    
            else % s3_1 > s2-s1
               % going to s3_2 would not help at all as s3 would just inc.
                if(s3_2 < s2-s1) 

                printf('Error with gph reshape of f3')
                end
                j = j + 1;
            end           

        elseif(sz_k == 1) 

            % Primary stuff, one piece quadratics should work with this
            k = kcols(1)
            [s3, y3] = find_values(f3,k,x3)
            if(s1 < s2-s3) 

                printf('Lesser than case')
                if(i <= sz1) 

                    i = i + 1;
                end
            elseif(s1 == s2-s3) 
    
                printf('Equality case')
                x_val = lambda1 * x1 + lambda2*x2
                f_val = lambda1 * x1 + lambda2 * x2 + lambda1*lambda2*y3
                s_val = s2 - s1
                
                col_add = [x_val;f_val;s_val]
                ka = [ka col_add] 
                % Increase x1 - since equality
                j = j + 1;
            else 
                % We solve for x1
                printf('Greater than')
                add_column = gph_ka_solve_equation(f1,f2,f3,i,j,lambda,2)
                ka  = [ka add_column]
                j = j + 1;
            end
        else
            printf('Error: Too many/less values for x3: Not possible')
            printf('Error with the code/proof');
        end
    end % Done with iterating over x2 
    
    % Iterating over x3 now
    i = 1
    j = 1
    k = 1
    
    while k<=sz3
        x3 = f3(1,k)
        s3 = f3(2,k)
        
        if(i <= sz1) 

            x1 = f1(1,i)
            s1 = f1(2,i)
        else 
            % TODO
            % 1. find_values should not be called if the function
            % is bounded
            % 2. Increment amount should be changed to the previous diff.
            x1  = x1 + 1 % right now just incrementing it by 1
            [s1,y1] = find_values(f1,sz1-1,x1)  
        end
        
        
        x3 = x1-x2
        kcols = gph_ka_colsearch(f3,x3)
        % kcols can be of maximum size 2
        sz_k = size(kcols,2)
        % size being 2 means that the intervals share the point
        if(sz_k == 2) 

            printf('Size of kcols is 2')
            k1 = kcols(1)
            k2 = kcols(2)
            s3_1 = f3(2,k1)
            s3_2 = f3(2,k2)
            if(s3_1 < s2-s1) 

                % check for s3_2 if its still lesser
                if(s3_2 < s2-s1) 

                    % lets increase x1 and see if its greater or equal
                    i = i + 1;                                  
                elseif(s3_2 == s2-s1) 

                    % record and move on
                    printf('Found a point. Include record code here')
                    i = i + 1;
                else
                    i = i + 1;
                    printf('s3_2 < s2-s1')
                end
            elseif(s3_1 == s2-s1) 

                % record and increase x1
                printf('Found a point2. Include record code here')    
            else % s3_1 > s2-s1
               % going to s3_2 would not help at all as s3 would just inc.
                if(s3_2 < s2-s1) 

                printf('Error with gph reshape of f3')
                end
                j = j + 1;
            end           

        elseif(sz_k == 1) 

            % Primary stuff, one piece quadratics should work with this
            k = kcols(1)
            [s3, y3] = find_values(f3,k,x3)
            if(s1 < s2-s3) 

                printf('Lesser than case')
                if(i <= sz1) 

                    i = i + 1;
                end
            elseif(s1 == s2-s3) 
    
                printf('Equality case')
                x_val = lambda1 * x1 + lambda2*x2
                f_val = lambda1 * x1 + lambda2 * x2 + lambda1*lambda2*y3
                s_val = s2 - s1
                
                col_add = [x_val;f_val;s_val]
                ka = [ka col_add] 
                % Increase x1 - since equality
                j = j + 1;
            else 
                % We solve for x1
                printf('Greater than')
                add_column = gph_ka_solve_equation(f1,f2,f3,i,j,lambda,2)
                ka  = [ka add_column]
                j = j + 1;
            end
        else
            printf('Error: Too many/less values for x3: Not possible')
            printf('Error with the code/proof');
        end
    end % Done with iterating over x2 
    
    disp(ka)
    
   
end