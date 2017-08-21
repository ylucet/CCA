function plqi = plq_split(plqf, i)
  % Helper function for plq_coSplit.
  % Pulls out the ith piece (ith row) of plqf, and makes that
  % row a complete PLQ function by adding +inf pieces
  % outside of the piece's bounds.

  plqi = [];
  if size(plqf,1) == 1 & plqf(1,1) ~= inf 

    error('plq_split: Can''t split a point-indicator function.');
    return;
  end;

  % Left, middle, and right regions (those that are applicable; i.e.
  % don't add a left piece to a function that stretches to x=-inf).
  if i ~= 1 
 plqi = [plqf(i-1,1), 0, 0, inf]; else plqi = [];  
  end;
  plqi = [plqi; plqf(i,:)];
  if plqf(i,1) ~= inf 
 plqi = [plqi; inf, 0, 0, inf];  
  end;
end
