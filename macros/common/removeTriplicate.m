function [Xnt,knt]=removeTriplicate(X,eps)
  %find all the values that are at least triplicate consecutively
  %and remove the middle values
    %gives Xnt=[1 2 2 3 3 4 4] and knt=[1 2 3 4 6 7 10]
  %while [Xnt,knt]=removeTriplicate([1 2 2 3 3 3 1 1])
  %gives Xnt=[1 2 2 3 3 1 1] and knt=[1 2 3 4 6 7 8 9]
  k1=find(abs(X(2:end)-X(1:end-1))<eps);%duplicate
  k2=find(abs(X(3:end)-X(1:end-2))<eps);
  k=intersect(k1,k2);%triplicate (at least)
  Xnt=X;
  knt=1:length(X);
  if ~isempty(k) 

    Xnt(k+1)=[];knt(k+1)=[];
  end  
end