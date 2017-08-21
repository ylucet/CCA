function [plqm,maxf] = plq_max(plqf1,plqf2)
  [plqm,maxf] = plq_oploop(plqf1,plqf2,@plq_max_indicator,@plq_maxoninterval);
end