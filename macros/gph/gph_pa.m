function [G,X1,X2,Y1,Fq1,Fq2] = gph_pa(G1,G2,lambda)
  %proximal average of 2 CONVEX gph functions
  %G1, G2: gph functions
  %lambda: real number. Lambda1=1-lambda;lambda2=lambda;
  %G: gph function: the proximal average of G0 and G1
  %X1,X2: points at which the infimum is attained; X=lambda1 X1+ lambda2 X2
  %Y1: Y1=f1(X1) and S = Y1-X: is the subdifferential of the pa
  %Fq1, Fq2: images of X1 and X2 so the pa is F=lambda1 Fq1 + lambda2 Fq2 - X^2/2
  eps = 1E-6;
  lambda1=1-lambda;lambda2=lambda;
  X1=G1(1,:)';S1=G1(2,:)';F1=G1(3,:)';
  X2=G2(1,:)';S2=G2(2,:)';F2=G2(3,:)';
  %compute P(X1) = (I+partial f2)^-1 circ (I+partial f1) (X1)
  %I+partial f1(X1) = X1 + S1
  XS1=X1+S1;
  %(I+partial f2)^-1 has piecewise linear graph going thru (X2+S2,X2)
  XS2=X2+S2;

%  %capture boundary behavior
%  xmin=min([X1;X2])-1;xmax=max([X1;X2])+1;
%  yminmax = interp1(X1,XS1,[xmin;xmax],'linear','extrap');
  
  %To capture all the information in G2, we need to enlarge XS1 
  %with XS2. So we compute the pre-image of XS2 by (I+    
  %XS1 can have duplicate values so clean up
  %BUT destroys any flat part!!
  [XS1u,k] = epsUnique(XS1,eps,true);X1u = X1(k);
  %XS2 can have duplicate values so clean up
  %BUT destroys any flat part!!  
  [XS2u,k] = epsUnique(XS2,eps,true);X2u = X2(k);  

  Xt1 = interp1(XS1u,X1u,XS2u,'linear','extrap');
  Xc1 = [X1u;Xt1]; Xc1 = sort(Xc1);%complete vector
  Yc1 = [XS1u;XS2u];%complete image by (I+%  Xc1 = [Xc1;[xmin;xmax]];  
%  Yc1 = [Yc1;yminmax];
  %[Xc1,k] = gsort(Xc1,'r','i');Yc1 = Yc1(k);%sort
  %sort by Yc1 to handle case Xc1 has duplicate values
  %with decreasing images in Yc1
  [Yc1,k] = sort(Yc1);%sort
  
    %since (I+  %going thru (X2+S2,X2)
  PX1 = interp1(XS2u,X2u,Yc1,'linear','extrap');
  %PX1 should be nondecreasing EXCEPT when
  %XC1 has 2 equal values with their images increasing
    %However, cannot compress PX1 if Yc1 has different images.
  %so only remove indexes that have the same value in all PX1, Xc1, Yc1
  Xc1 = sort(Xc1); Yc1 = sort(Yc1);  
  [t, k] = unique([PX1';Xc1';Yc1']', 'rows');
  t = t';
  k = k';
  PX1=PX1(k);Xc1=Xc1(k);Yc1=Yc1(k);
  %[PX1,k] = epsUnique(PX1,eps,
  X = lambda1 * Xc1 + lambda2 * PX1;
  S = Yc1 - X;
  Fc1 = gph_eval(G1,Xc1);
  F2PX1 = gph_eval(G2,PX1);
  Fq1 = Fc1+Xc1.^2/2; Fq2 = F2PX1+PX1.^2/2;
  F = lambda1 * Fq1 + lambda2 * Fq2 - X.^2/2;
  G = [X';S';F'];
  if size(G,2)==1 
    G=[G G+[0;1;0]];%need 2 points with gradient on vertical line as special case of singleton indicator
  else
  %clean up: make sure S is convex i.e. no more than 2 duplicate values in X
  %otherwise take the outer values
    [Xnt,knt]=removeTriplicate(X,eps);
    G=G(:,knt);
    if size(G,2)>2 
%not an indicator function
      %clean up left boundary: x0==x1 and s0<s1 implies f0=inf
      if (G(1,2) - G(1,1) < eps) & (G(2,1) < G(2,2)+eps) 

        G(3,1)=inf;
      end
      %clean up right boundary: xn==xn-1 and sn>sn-1 implies fn=inf
      if (G(1,end) - G(1,end-1) < eps) & (G(2,end) > G(2,end-1) -eps) 

        G(3,end)=inf;
      end    
    end
  end
  X1=Xc1;X2=PX1;Y1=Yc1;  
end