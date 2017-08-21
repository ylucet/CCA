%The following routine solves [PROBLEM 2.].
function [plqco] = conv_interval_func(x,a,b,c,x1,x3,x5),
        EPS=1E-10; x(1)=x1;x(3)=x3;x(5)=x5;
    
        %solving the quadratic for x(2)
                if a(1) ~=  0 & x(5) < inf 

            A1 = -a(1);
            B1 = 2*a(1)*x5;
            C1 = c(1) + b(1)*x5 - a(2)*x5.^2 - b(2)*x5 - c(2);
            D1 = B1.^2 - 4*A1*C1;
            if D1<0 

              printf('D1<0 in _conv_interval_func');
              pause
              cerror('_conv_interval_func: D1<0. Is your function continuous on ri dom?');
            end
            pr1 = (-B1 + sqrt(D1))/(2*A1); %solution is x2  
            nr1 = (-B1 - sqrt(D1))/(2*A1); %negative root required for the LINEAR-QUADRATIC CASE.

            if x(1) <= pr1 & pr1 <= x(3) 
 x(2) = pr1; plqco=[x(2),a(1),b(1),c(1);
     plq_conv_buildl(x,a,b,c,1,2,2,5)];
            elseif x(3) <= pr1 & pr1 <= x(5) 
 x(4)=pr1; plqco=[plq_conv_buildl(x,a,b,c,1,1,2,4);x(5),a(2),b(2),c(2)]; %potentially useless
            elseif x(1) <= nr1 & nr1 <= x(3) 
 x(2) =pr1; plqco=[x(2),a(1),b(1),c(1);plq_conv_buildl(x,a,b,c,1,2,2,5)];
            elseif x(3) <= nr1 & nr1 <= x(5) 
 x(4)=pr1; plqco=[plq_conv_buildl(x,a,b,c,1,1,2,4);x(5),a(2),b(2),c(2)]; %potentially useless
            else plqco=plq_conv_buildl(x,a,b,c,1,1,2,5);
            end; 

        %solving the quadratic for x(4)
        %elseif a(2) <> 0 & x(1) > -inf & x(5) < inf then
        elseif a(2) ~=  0 & x(1) > -inf 

            A2 = a(2);
            B2 = -2*a(2)*x(1);
            C2 = -b(2)*x(1) + a(1)*x(1).^2 + b(1)*x(1) + c(1) - c(2);
            D2 = B2.^2 - 4*A2*C2;
            pr2 = (-B2 + sqrt(D2))/(2*A2);  
            nr2 = (-B2 - sqrt(D2))/(2*A2);
            
            if x(3) <= pr2 & pr2 <= x(5)  
 x(4)=pr2; plqco=[plq_conv_buildl(x,a,b,c,1,1,2,4);x(5),a(2),b(2),c(2)];
            elseif x(1) <= pr2 & pr2 <= x(3)  
 x(2)=pr2; plqco=[x(2),a(1),b(1),c(1);plq_conv_buildl(x,a,b,c,1,2,2,5)]; %potentially useless
            elseif x(3) <= nr2 & nr2 <= x(5)  
 x(4)=nr2; plqco=[plq_conv_buildl(x,a,b,c,1,1,2,4);x(5),a(2),b(2),c(2)];
            elseif x(1) <= nr2 & nr2 <= x(3)  
 x(2)=nr2; plqco=[x(2),a(1),b(1),c(1);plq_conv_buildl(x,a,b,c,1,2,2,5)]; %potentially useless
            else plqco=plq_conv_buildl(x,a,b,c,1,1,2,5);
            end;
        else plqco=plq_conv_buildl(x,a,b,c,1,1,2,5); 
        end;
        
        

end
