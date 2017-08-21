function [plqa,extra] = plq_addoninterval(q1,q2,lb,ub) 
 plqa = [ub,(q1+q2)];
 extra = [];
 %printf(" Add: q1=[i,i,i],q2=[i,i,i] lb=i,ub=i -- plqa=[i,i,i,i]",q1(1,1),q1(1,2),q1(1,3),q2(1,1),q2(1,2),q2(1,3),lb,ub,plqa(1,1),plqa(1,2),plqa(1,3),plqa(1,4));
end