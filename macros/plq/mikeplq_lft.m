%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%PLQ CONJUGATE%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function plqfstar = mikeplq_lft(plqf) 
    x=plqf(:,1);a=plqf(:,2);b=plqf(:,3);c=plqf(:,4);
    n = size(x,1); %number of rows
    i=1;j=1;   
    while i <= n, 
        plqType = getType(n,x,a,b,c,i);
        switch plqType,
        case 6 
%BOUNDED RHS
          s(i) = inf;
          sa(i) = 0;
          sb(i) = x(i-1);
          sc(i) = (-1)*a(i-1)*x(i-1).^2-b(i-1)*x(i-1)-c(i-1);
          j = j + 1;
        case 5 
%BOUNDED LHS
          s(i) = 2*a(i+1)*x(i) + b(i+1);
          sa(i) = 0;
          sb(i) = x(i);
          sc(i) = (-1)*a(i+1)*x(i).^2-b(i+1)*x(i)-c(i+1);
          j = j + 1;
        case 3 
%LINE - TO - POINT
            s(i) = b(i);sa(i) = 0;sb(i) = 0;sc(i) = -c(i);
        case 4 
%POINT - TO - LINE
            s(i) = inf;sa(i) = 0;sb(i) = x(i);sc(i) = -c(i);
        case 1 
%linear - TO - quadratic or linear
        %first row of conjugate matrix
        if i < n 
 
                s(j) = b(i);
        else
                s(j) = inf;
        end
            sa(j) = 0;sb(j) = 0;sc(j) = inf;
            
        %second row of conjugate matrix
        if i < n 

            if s(j) < 2*a(i+1)*x(i) + b(i+1) 

                s(j+1) = 2*a(i+1)*x(i) + b(i+1);
                sa(j+1) = 0;
                sb(j+1) = x(i);
                sc(j+1) = (-1)*b(i)*x(i) - c(i);
                j = j + 2;
            else j = j + 1;
            end
        end
        case 2 
%quadratic - TO - quadratic or linear
            %first row of conjugate matrix
            if i < n 

                s(j) = 2*a(i)*x(i) + b(i);
            else 
                s(j) = inf;
            end
            sa(j) = 1/(4*a(i));
            sb(j) = (-1/2)*(b(i)/a(i));
            sc(j) = (1/4)*(b(i)*b(i))/a(i) - c(i); %potential for infinity value

            %second row of conjugate matrix
            if (i < n) 

                if s(j) < 2*a(i+1)*x(i) + b(i+1) 

                    s(j+1) = 2*a(i+1)*x(i) + b(i+1);
                    sa(j+1) = 0;
                    sb(j+1) = x(i);
                    sc(j+1) = -a(i)*x(i)*x(i) - b(i)*x(i) - c(i);
                    j = j + 2;
                else j = j + 1;
                end
            end
        end
        i = i + 1;
    end
    plqfstarDirty = [ s' , sa' , sb' , sc' ];
    plqfstar = plq_clean(plqfstarDirty);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%PLQ CONJUGATE%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
