function [plqo,extra] = plq_oploop(plqf1,plqf2,plq_op_indicator,plq_oponinterval)
    f1row = 1;f2row = 1;
  plqo=[];extra=[];
  eps=1E-6;%precision below which 2 numbers are considered equals
  %sorting the domain partitions of the plq functions
  f1x=plqf1(:,1);
  f2x=plqf2(:,1);
  z = sort([f1x;f2x]);
  z = unique(z);
  ii=(z(2:end)-z(1:end-1))<eps;
  z = [z(~ii);z(end)];%remove close values as being equals
  p = size(z,1);
  if (size(plqf1,1) == 1 & plqf1(1,1) < inf) | (size(plqf2,1) == 1 & plqf2(1,1) < inf) 
 %plqf1 is singleton indicator function.
    [plqo,extra] = plq_op_indicator(plqf1,plqf2);
  else %plqf1,plqf2 are neither singleton indicator functions.
    [o,e] = plq_oponinterval(plqf1(1,2:end),plqf2(1,2:end),-inf,z(1));
    plqo = [plqo;o];
    extra = [extra;e];
    %Main Loop
    for i=1:(p-1),
      %for plq's that have common partition point --See test_plq_add "testQLQmoothPlusQLQNonsmooth"
      if abs(plqf1(f1row,1)- z(i))<eps & abs(plqf2(f2row,1)-z(i))<eps 

        f1row = f1row + 1;
        f2row = f2row + 1;
      elseif abs(plqf1(f1row,1) - z(i))<eps 
 
        f1row = f1row + 1;
      elseif abs(plqf2(f2row,1) - z(i))<eps 
 
        f2row = f2row + 1;
      else 
        cerror('Error in plq_oploop: x(i) must be increasing');
      end;
      [o,e] = plq_oponinterval(plqf1(f1row,2:end),plqf2(f2row,2:end),z(i),z(i+1));
      plqo = [plqo;o];
      extra = [extra;e];
    end;
  end;  
  plqo = plq_clean(plqo);
end
