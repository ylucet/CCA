function [plqic, argmin] = plq_infconv_brute(plqf, plqg, swapArgmin, plotArgmin)
  % Computes the plq_min of the convolutions, as computed by
  % plq_infconv_brute_d(), for all nf*ng pairs of (f,g) pieces.
  % Assumes plqf and plqg are not point indicator functions.
  % Simply ignores non-finite pieces.

  if (nargin < 3) 
    swapArgmin = true;  
  end;
  if (nargin < 4) 
    plotArgmin = false;  
  end;

%removed: plq_is_convex is not implemented so crashes unit tests
%why do we need to swap arguments if plqg is not convex anyway??
%  if (~plq_is_convex(plqg)) then
%	temp = plqf;
%	plqf = plqg;
%	plqg = temp;
%  end;

  calcArgmin = (nargout >= 2);
  plqic = [inf, 0, 0, inf];
  argmin = [inf, 0, 0, inf];
  nf = size(plqf, 1);
  ng = size(plqg, 1);

  for i = 1:nf
    if (plqf(i,4) == inf) 
 continue;  
    end;

    for j = 1:ng
      if (plqg(j,4) == inf) 
 continue;  
      end;
      if (i == 1) 
 u(1) = -inf; else u(1) = plqf(i-1,1);  
      end;
      if (j == 1) 
 u(2) = -inf; else u(2) = plqg(j-1,1);  
      end;
      v(1) = plqf(i,1);
      v(2) = plqg(j,1);

      %printf("plq_infconv2_brute: i==     
      [plqh, lb, amin] = plq_infconv_brute_d(plqf(i,:), plqg(j,:), u, v, swapArgmin);
      plqh = [lb,0,0,inf; plqh; inf,0,0,inf];

      if (~calcArgmin) 

        plqic = plq_min(plqic, plqh);
      else
        amin = [lb,0,0,inf; amin; inf,0,0,inf];
        %plq_plotMultiple(-3,15,plqh);
        %printf("        %disp(amin);

        % Update the proximal mapping.
        % Where replace the intervals in the current argmin
        % where minf(:,1)==2 with the new argmin.
        [plqic, minf] = plq_min(plqic, plqh);
        bounds = minf(find(minf(:,1)==2),2:3)';
        for bound = bounds
          argmin = plq_replace(argmin, amin, bound(1), bound(2));
        end;

        if (plotArgmin) then
          disp(argmin);
          clf();
          plq_plotMultiple(-5, 5, argmin, amin);
          if (plqf(i,3) < plqg(j,3)) then
            xtitle(sprintf("(%d,%d) swapped", i, j));
          else
            xtitle(sprintf("(%d,%d)", i, j));
          end;
          scanf("%s");
        end;
      end;
    end;
  end;
  if (calcArgmin) 

    argmin = plq_clean(argmin);
  end;
end