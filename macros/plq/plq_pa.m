%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%PROXIMAL AVERAGE%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function pa = plq_pa(f1,f2,lambda_pa,isConvex)
    if nargin<=3 
 isConvex=true; 
    end;%default to convex functions
    pa=[];%default value in case of error
%f[lambda] = (lambda(f1 + (1/2)normsquared)* + (1 - lambda)(f2 + (1/2)normsquared)*)* - (1/2)normsquared
    normsquared = [inf, 1/2, 0, 0];
    negnormsquared = plq_scalar(normsquared,-1);
    f1normsquared = plq_add(f1,normsquared);
    f2normsquared = plq_add(f2,normsquared);
    f1normsquaredstar = plq_lft(f1normsquared,isConvex);
    f2normsquaredstar = plq_lft(f2normsquared,isConvex);
    f1normsquaredstarlambda = plq_scalar(f1normsquaredstar,1-lambda_pa);%1-lambda first function
    f2normsquaredstarlambda = plq_scalar(f2normsquaredstar,lambda_pa);
    f1normsquaredstarlambda=plq_clean(f1normsquaredstarlambda);%remove floating point errors
    proxadd = plq_add(f1normsquaredstarlambda,f2normsquaredstarlambda);
    proxaddstar = plq_lft(proxadd);
    proxaddstar = plq_clean(proxaddstar);
    pa = plq_add(proxaddstar,negnormsquared);
end