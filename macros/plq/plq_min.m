function [plqm,minf] = plq_min(plqf1,plqf2),
    [plqm, minf] = plq_max(plq_scalar(plqf1,-1),plq_scalar(plqf2,-1));
    plqm = plq_scalar(plqm,-1);
end