%computes the maximum of two functions under the assumption that the difference of q1 - q2 is quadratic!!!!!
function [plq,maxq] = dq_maxoninterval(q1,q2,lb,ub,a,b,c)
    delta = b.^2 - 4*a*c; %calculating the discriminant of the quadratic 
    %printf(" a:     
    if delta > 0 
 %there are two real roots
        %finding the zeros of qd
        x(1) = (-b - sqrt(delta))/(2*a);
        x(2) = (-b + sqrt(delta))/(2*a);
            x = sort([x]);
        if (x(1) < lb & x(2) > ub) | (x(1) > ub & x(2) > ub) | (x(1) < lb & x(2) < lb) 
 %both zeros are outside our interval
             %plq = maxoninterval(q1,q2,dq,lb,ub);
             [plq,i] = maxoninterval(q1,q2,lb,ub,a,b,c);
             maxq = [i,lb,ub];
        elseif x(1) >= lb & x(2) <= ub 
 %both zeros are inside our interval (NOTE: x(1),x(2) are sorted)
            [plq_i1,i1] = maxoninterval(q1,q2,lb,x(1),a,b,c);
            [plq_i2,i2] = maxoninterval(q1,q2,x(1),x(2),a,b,c);
            [plq_i3,i3] = maxoninterval(q1,q2,x(2),ub,a,b,c);
            plq = [plq_i1;plq_i2;plq_i3];
            maxq = [i1,lb,x(1);i2,x(1),x(2);i3,x(2),ub];
        elseif x(1) >= lb & x(1) <= ub 
 %only left root inside interval
          [plq_i1,i1] = maxoninterval(q1,q2,lb,x(1),a,b,c);
            [plq_i2,i2] = maxoninterval(q1,q2,x(1),ub,a,b,c);
            plq = [plq_i1;plq_i2];
            maxq = [i1,lb,x(1);i2,x(1),ub];
        else %only right root inside interval
            [plq_i1,i1] = maxoninterval(q1,q2,lb,x(2),a,b,c);
            [plq_i2,i2] = maxoninterval(q1,q2,x(2),ub,a,b,c);
            plq = [plq_i1;plq_i2];
            maxq = [i1,lb,x(2);i2,x(2),ub];
        end
    elseif delta < 0 
 %there are 2 complex roots (No real roots) 
        [plq,i] = maxoninterval(q1,q2,lb,ub,a,b,c);
        maxq = [i,lb,ub];
    else %delta = 0 then there is 1 real root
        x(1) = (-b + sqrt(delta))/(2*a);
        if x(1) <= lb | x(1) >= ub 
 %the root is outside our lower and upper bound
            [plq,i] = maxoninterval(q1,q2,lb,ub,a,b,c);
            maxq = [i,lb,ub];
        else %zero is inside the interval
            [plq,i] = maxoninterval(q1,q2,lb,x(1),a,b,c); 
            plq(1,1) = ub; %since the quadratic is tangent to the x-axis, we know that it does not cut the axis
            maxq = [i,lb,ub];
        end
    end    
end
