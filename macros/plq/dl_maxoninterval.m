%computes the maximum of two functions under the assumption that difference of q1 - q2 is linear function!!!!!
function [plq,maxq] = dl_maxoninterval(q1,q2,lb,ub,a,b,c)
    if b == 0 
 %horizontal line, i.e. no intersection with the x-axis
        plq = maxoninterval(q1,q2,lb,ub,a,b,c);
        if (c > 0) 
 maxq = [1,lb,ub]; else maxq = [2,lb,ub];  
        end;
    else 
        x = -c/b; %y=bx+c --> find x-intercept 0=bx+c --> x = -c/b
        if x <= lb | x >= ub 

            [plq,i] = maxoninterval(q1,q2,lb,ub,a,b,c);
            maxq = [i,lb,ub];
        else
            [plq_i1,i1] = maxoninterval(q1,q2,lb,x,a,b,c);
            [plq_i2,i2] = maxoninterval(q1,q2,x,ub,a,b,c);
            plq = [plq_i1;plq_i2];
            maxq = [i1,lb,x;i2,x,ub];
        end
    end;
end