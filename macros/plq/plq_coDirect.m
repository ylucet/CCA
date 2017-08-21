function [plqco,iters]=plq_coDirect(plqf)
    EPS=1E-10;
    plqf_original=plqf; plqfLHS=[];plqfRHS=[];
    iters = 0;
    
    % Special case: f(x) = inf.
    if (size(plqf,1) == 1 & plqf(1,1) == inf & any(plqf(1,2:end) == inf)) 

	    plqco = plqf;
	    return;
    end;

    %Bounded plq functions will have an infinity value as a coefficient in either
    %the first row or the last row, simply remove these pieces and add these pieces
    %after the convex hull has been computed.
    if any(plqf(1,2:end) == inf) 
 plqfLHS = plqf(1,:); plqf=plqf(2:end,:);  
    end;
    if any(plqf(end,2:end) == inf) 
 plqfRHS = plqf(end,:); plqf=plqf(1:end-1,:);  
    end;
    
    n = size(plqf,1);
    x=plqf(:,1);a=plqf(:,2);b=plqf(:,3);c=plqf(:,4); %update the coefficients
    if ( isempty(plqfLHS) & a(1) < 0 ) ...
          | (isempty(plqfRHS)& a(n) < 0 ) ...
          | ( isempty(plqfLHS) & isempty(plqfRHS) & a(1) == 0 & a(n) == 0 & b(1) > b(n) ) 

      plqco=[inf,0,0,-inf];
      return;
    end;
    
    % co is not -inf everywhere, so the only single-piece concave 
    % case to deal with is a bounded concave quadratic.
    if n == 1 & a(1) < 0 

      x1 = plqf(1,1);
      x0 = plqfLHS(1,1);
      y0 = plqf(1,2)*x0.^2 + plqf(1,3)*x0 + plqf(1,4);
      y1 = plqf(1,2)*x1.^2 + plqf(1,3)*x0 + plqf(1,4);
      b = (y1 - y0) / (x1 - x0);
      c = y0 - x0 * b;
      plqf(1,2:4) = [0, b, c];
    end;
   
    i=1;
    while i <= n-1 & n >= 2, 
        iters = iters + 1;
        a=(a(:,1));
 b=(b(:,1)); c=(c(:,1));
        %Considering a PLQ function with two pieces, it is nonconvex if the following condition holds.
        if (2*a(i)*x(i)+b(i)) - (2*a(i+1)*x(i)+b(i+1)) > EPS |  a(i) < 0 | a(i+1) < 0 

            if i >= 2 
 x1 = plqf(i-1,1); 
            elseif ~isempty(plqfLHS) 
 x1 = plqfLHS(1,1);
            else x1 = -inf;  
            end; 
            f1=plqf(i,:); f2=plqf(i+1,:);x3=f1(1,1); x5=f2(1,1);
            %printf(" f1=[            %plq_plot(plqf_original,plqf,-inf,inf); 
            co = plq_conv_on_interval(f1,f2,x1,x3,x5);
            maybeBacktrack = true;
            offset = 0;

            % We're going to replace plqf(i:i+1,:) with co.
            % If plqf(i-1,:) matches co(1,:), extend plqf(i-1,:)
            % instead of adding co(1,:).
            if i > 1 

                if all((plqf(i-1,2:4) - co(1,2:4)) == 0) 

                    maybeBacktrack = false;
                    plqf(i-1,1) = co(1);    % co(1,:) has the same function as plqf(i-1,:).
                    co = co(2:end,:);         % Hence don't insert co(1,:) at the end.
                    % If plqf(i-1:i+1,:) collapse to one piece, then maybe
                    % plqf(i-1:i+1,:) and plqf(i+2,:) need to collapse as well.
                    if isempty(co)

                        if all((plqf(i-1,2:4) - plqf(i+2,2:4)) == 0) 

                            plqf(i-1,:) = [];
                            % co has been "inserted", no more work to do.
                        end;
                    end;
                end;
            end;

            % Likewise, we may need to merge with plqf(i+2,:).
            if ~isempty(co) & i < n-1 

                % Either co has two different pieces, or one piece which
                % is distinct from plqf(i-1,:).
                if all((co(end,2:4) - plqf(i+2,2:4)) == 0) 

                    % Merge co($,:) and plqf(i+2,:), by not inserting co($,:).
                    % No need to check if co($-1,:) and plqf(i+2,:) merge too,
                    % that's handled above.
                    co(end,:) = [];
                    offset = offset + 1;
                end;
            end;

            plqf = [plqf(1:i-1,:); co; plqf(i+2:end,:)];
            if maybeBacktrack 

                % If now, f'(x(i-1)) > f'(x(i)), then we need to backtrack.
                if i == 1 

                    sl = -inf;
                else
                    sl = 2*plqf(i-1,2)*x1 + plqf(i-1,3);
                end;
                sr = 2*plqf(i,2)*x1 + plqf(i,3);
                if sl > sr 

                    maybeQlqLoop = false;
                    if i > 1 & plqf(i,2) == 0 & plqf(i+1,2) ~= 0 

                        if plqf(i-1,2) ~= 0 

                            maybeQlqLoop = true;
                        end;
                    end;

                    if maybeQlqLoop 

                        % We have entered a QLQ loop, with the linear
                        % piece converging to the convex hull between
                        % the two quadratics.  Delete the linear piece,
                        % and treat as a QQ case.
                        [plqf, i] = plq_conv_qlq(plqf, i);
                    else
                        % Simply created a nonconvexity at x1.
                        i = i - 1;
                    end;
                else
                    maybeBacktrack = false;
                end;
            end;
            
            if ~maybeBacktrack 

                % Not backtracking, advance i to the last piece we know
                % to be convex, that is, the last piece in the co we
                % just inserted.
                i = i + (size(co, 1) - 1) + offset;
            end;

            %plq_plot(plqf_original,plqf,-inf,inf);
        else
            i=i+1;
        end;
        n = size(plqf,1); %update size of the PLQ function
        x=plqf(:,1);a=plqf(:,2);b=plqf(:,3);c=plqf(:,4); %update the coefficients
    end;
    plqco=[plqfLHS;plqf;plqfRHS];
end  
