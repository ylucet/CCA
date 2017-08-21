function [plq,d] = plq_proj(f,x,p)
%projection in norm p (p in 1, 2, +inf) of f (nonconvex) using grid x
%plq is a clean up of the resulting piecewise affine function
%d is the distance between the 2 functions d=||f-u||_p
%use only pointwise evaluation of the function to compute pointwise evaluation
%of the projection using quadratic programming
    if (isdef('quapro')) 
	
      if nargin<=2, p=2; 
      end;%default to L2 norm
      if p == 2 

          n=length(x);
          h=x(2)-x(1);%grid stepsize (assume uniform grid)
          %min||f-u||_p st u convex
          Q=2*eye(n,n)*h;p=-2*f*h;%minimize 0.5*u'*Q*u + p'
          %u convex means u_i+2 + u_i >= 2 u_i+1 for a regular grid.
          o=ones(size(n,1));  C=diag(o)-2*diag(o(1:end-1),1)+diag(o(1:end-2),2);
          C=C(1:end-2,:);%remove last 2 rows
          C=-C;%need C x <= b
          b=zeros(size(n-2,1));       
          [u,lagr,val]=quapro(Q,p,C,b); ......
          %use quapro since qld
                  %doesnot seem reliable as of Scilab 4.1 %
          %ci=[];cs=[];me=0;[u,lagr,info]=qld(Q,p,C,b,ci,cs,me);

          d=0.5*u'*Q*u+p'*u+f'*f*h;
          plq=plq_build_d(x,u);
          plq=plq_clean(plq);
      else
          plq = []; d = 0;
          cerror(sprintf('plq_proj: option p=i not implemented', p));
      end
    else
    	 cerror('This function needs the quapro toolbox. Please install it first.');
    end;
    
end