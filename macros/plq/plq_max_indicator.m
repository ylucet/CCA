function [plqmi,maxq] = plq_max_indicator(plqf1,plqf2)
  maxq = [];
  if (size(plqf1,1) == 1 & plqf1(1,1) < inf) & (size(plqf2,1) == 1 & plqf2(1,1) < inf) 

      %both plqf1,plqf2 are singleton indicator functions
      if plqf1(1,1) ~= plqf2(1,1) 
 plqmi = [inf,0,0,inf];
      else %plqf1(1,1) == plqf2(1,2) have a singleton point in common
          y1 = plq_eval(plqf1,plqf1(1,1));
          y2 = plq_eval(plqf2,plqf2(1,1));
          if y1 >= y2 
 plqmi=plqf1; else plqmi=plqf2;  
          end; 
      end;
  elseif (size(plqf1,1) == 1 & plqf1(1,1) < inf) 
 %plqf1 is a singleton indicator function
      y1 = plq_eval(plqf1,plqf1(1,1));
      y2 = plq_eval(plqf2,plqf1(1,1));
      if y1 >= y2 
 plqmi=plqf1; else plqmi=[plqf1(1,1),0,0,y2];  
      end;
  else %plqf2 is a singleton indicator function
      y1 = plq_eval(plqf2,plqf2(1,1));
      y2 = plq_eval(plqf1,plqf2(1,1));
      if y1 >= y2 
 plqmi=plqf2; else plqmi=[plqf2(1,1),0,0,y2];  
      end;
  end
end