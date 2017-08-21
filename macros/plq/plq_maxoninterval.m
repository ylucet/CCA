%l1,l2,q1,q2 are all represented by the formar [a,b,c] which represents ax^2 + bx + c
%Each corresponding function will find the maximum function between two functions
%either quadratic-linear, quadratic-quadratic, linear-linear which is valid only 
%within the interval [lb,ub] the lower and upper bound.
%main function 
%computes the maximum of two functions under the assumption that q1 - q2 is linear or quadratic.
%DOES NOT HANDLE SINGLETON INDICATOR FUNCTIONS.
function [plq,maxq] = plq_maxoninterval(q1,q2,lb,ub)
        %printf(" q1=[i,i,i],q2=[i,i,i] lb=i,ub=i",q1(1,1),q1(1,2),q1(1,3),q2(1,1),q2(1,2),q2(1,3),lb,ub);
    if all(q1==q2) 

      plq=[ub,q1]; %printf(" plq_max: [i,i,i,i]",plq(1,1),plq(1,2),plq(1,3),plq(1,4));
      maxq=[];
      return;
    end;
        %to find where q1 > q2 find where (q1 - q2) > 0    
    dlq = (q1 - q2); %WARNING: the difference of two quadratics is linear! or quadratic!
    a=dlq(1,1);b=dlq(1,2);c=dlq(1,3);
    if a == 0 

      %dlq is linear
      [plq,maxq] = dl_maxoninterval(q1,q2,lb,ub,a,b,c); %printf(" plq_max: [i,i,i,i]",plq(1,1),plq(1,2),plq(1,3),plq(1,4)); 
    else
      %dlq is quadratic
      [plq,maxq] = dq_maxoninterval(q1,q2,lb,ub,a,b,c); %printf(" plq_max: [i,i,i,i] Q",plq(1,1),plq(1,2),plq(1,3),plq(1,4)); 
    end
end