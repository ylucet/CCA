%%%%%%%%%%PLQ CONVEX HULL%%%%%%%%%%%%%%%%%%%%%%%%
%TODO, (1) UPDATE PLQ_EVAL FOR NONCONVEX FUNCTIONS?.
%      (2) UPDATE PLQ_BUILD FOR NONCONVEX FUNCTIONS.


function plqco = plq_co(plqf, method)
  % Allowed values for method: direct, split.
  if nargin < 2 
 method = 'direct';  
  end;
  if method == 'direct' 

    plqco = plq_coDirect(plqf);
  else
    plqco = plq_coSplit(plqf);
  end;
end