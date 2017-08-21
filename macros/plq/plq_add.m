function [plqa] = plq_add(plqf1,plqf2)
  plqa = plq_oploop(plqf1,plqf2,@plq_add_indicator,@plq_addoninterval);
end