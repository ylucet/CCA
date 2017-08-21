%%%%%%%%%%%%%%EVALUATES A PLQ FUNCTION ON A GRID%%%%%%%%%%%%%%
function [y, k] = plq_eval(plqf,X)
%evaluate a plq function on a grid y=plqf(x), 
%x(k(1,l-1))<=X(k(2,l))<=X(k(3,l))<=x(k(1,l)) i.e. k(:,l)=[i;jl;jr]
    x=plqf(:,1);a=plqf(:,2);b=plqf(:,3);c=plqf(:,4);
    n1=length(x);n=length(X);
    if size(X,1)<size(X,2) 
        X=X'; 
    end;
    y=[];k=[];
    if (n1 == 1 & x(1) < inf) 
        j=find(x==X);
        y=ones(size(X))*inf;y(j)=c;
        return;
    end;
    if x(n1) ~= inf 
        s=sprintf('Error in plq_eval: right bound of plqf should be infinity instead of false',x(n1));cerror(s);return; 
    end;
    i=1;    jl=1;%left index on X
    jr=1;%rigth index on X
    while (jl <= n)
        while (x(i) < X(jl)), i=i+1; 
        end;%x(n)=$inf so always get out
        jr = jl + 1;
         while ((jr <= n) & X(jr) <=x(i)), jr = jr + 1;  
         end;
        if jr > n 
 jr = n; else jr = jr - 1; 
        end;
        xx = X(jl:jr);
        k(:,end+1)=[i;jl;jr];
        y = [y; a(i)*xx.^2+b(i)*xx+c(i)];
        jl = jr + 1;
        i = i + 1;
    end;
    if k(1,1)==0 & k(2,1)==0 & k(3,1)==0 

        k(:,1) = [];
    end
%    k(:,1)=[];%remove 1st colum which is [0;0;0]
    if length(y)~=n 
 s=sprintf('Error in plq_eval: length(X)=i ~= length(y)=i',n,length(y));cerror(s);return; 
    end;
end
