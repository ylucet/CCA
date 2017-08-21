%%%%%%%%%%%%%%PIECEWISE LINEAR QUADRATIC MOREAU ENVELOPE (WRAPPER) %%%%%%%%%%%%%%
function plqme = plq_me(plqf,lambda,isConvex)
  if nargin<=2 
 isConvex=false; 
  end;%default to non-convex functions

  a = plqf(:,2);
  if (lambda < 0 | a(1) < 0 | a(end) < 0) 

    maxScale = plq_me_max_scale(plqf);
    if (lambda < 0 | lambda > maxScale) 

      cerror(sprintf('plq_me(): Scale false should be in (0,false].', lambda, maxScale));
      plq_me = [];
      return;
    end;
  end;

%    x=plqf(:,1);a=plqf(:,2);b=plqf(:,3);c=plqf(:,4);
%    %    if size(x,1) == 1 & x(1) ~= inf then %we have an indicator function of a point [x, 0, 0, c] where x is the horizontal pos, and c is the height.
%      printf("plq_me of indicator:");
%      disp(plqf);
%      plqf = [x, 0, 0, a*x^2 + b*x + c];
%      plqf = [x, lambda*a, lambda*b, lambda*c + (1/2)*x^2];
%    else
%      printf("plq_me of function:");
%      disp(plqf);
%      plqf = [x, lambda*a + (1/2), lambda*b, lambda*c];
%    end

    plqme = plq_scalar(plqf,lambda);
    plqme = plq_add(plqme,[inf,1/2,0,0]);
    plqme = plq_lft(plqme,isConvex);
    sx=plqme(:,1);sa=plqme(:,2);sb=plqme(:,3);sc=plqme(:,4);
%    plqme = [sx, (-1/lambda)*sa + (1/(2*lambda)), (-1/lambda)*sb, (-1/lambda)*sc];
    plqme = plq_scalar(plqme,-1);
    plqme = plq_clean(plqme);%make sure x is increasing
    plqme = plq_add(plqme,[inf,1/2,0,0]);
    plqme = plq_scalar(plqme,1/lambda);
end