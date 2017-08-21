function [plqai,extra] = plq_add_indicator(plqf1,plqf2)
  extra = [];
  if (size(plqf1,1) == 1 & plqf1(1,1) < inf) & (size(plqf2,1) == 1 & plqf2(1,1) < inf) 

      %both plqf1,plqf2 are singleton indicator functions
      if plqf1(1,1) ~= plqf2(1,1) 
 plqai = [inf,0,0,inf];
      else
          plqai = [plqf1(1,1),0,0,plqf1(1,4)+plqf2(1,4)];
      end;
  elseif (size(plqf1,1) == 1 & plqf1(1,1) < inf) 
 %plqf1 is a singleton indicator function
      y2 = plq_eval(plqf2,plqf1(1,1));
      plqai = [plqf1(1,1),0,0,plqf1(1,4)+y2];
  else %plqf2 is a singleton indicator function
      y2 = plq_eval(plqf1,plqf2(1,1));
      plqai = [plqf2(1,1),0,0,plqf2(1,4)+y2];
  end
end