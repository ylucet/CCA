% _soqs_slopes
%
% Auxillary function for _soqs_build to calculate the derivative at each
% data point. The slopes provided will insure that an osculatory
% quadratic spline will have one additional knot between two adjacent
% points of interpolation. Convexity and monotonicity are preserved
% wherever these conditions are compatible with the data.
%
% The code is taken partially from Algorithm 574: Shape-Preserving
% Osculatory Quadratic Splines, Feb. 4, 1981 with permission from the
% Association for Computing Machinery (ACM).
%
% XTAB contains the abscissas of the data points
% YTAB contains the ordinates of the data points
% MTAB contains the value of the first derivative at each data point
function MTAB=soqs_slopes(XTAB,YTAB)
    NUM = max(size(XTAB));
    NUM1 = NUM - 1;
    IM1 = 1;
    I = 2;
    I1 = 3;
    
    % Calculate the slopes of the two lines joining the first three data points.
    YDIF1 = YTAB(2) - YTAB(1);
    YDIF2 = YTAB(3) - YTAB(2);
    M1 = YDIF1/(XTAB(2)-XTAB(1));
    M1S = M1;
    M2 = YDIF2/(XTAB(3)-XTAB(2));
    M2S = M2;

    
    while (1)
      % if one of the preceding slopes is zero or if they have opposite
      % sign, assign the value zero to the derivative at the middle point.
      if (M1==0|M2==0|(M1*M2)<0) 

	MTAB(I) = 0;
      else

	if (abs(M1)>abs(M2))
	  % calculate the slope by extending the line with slope M1
	  XBAR = (YDIF2/M1) + XTAB(I);
	  XHAT = (XBAR+XTAB(I1))/2;
	  MTAB(I) = YDIF2/(XHAT-XTAB(I));
	else           
	  % calculate the slope by extending the line with slope M2
	  XBAR = (-YDIF1/M2) + XTAB(I);
	  XHAT = (XTAB(IM1)+XBAR)/2;
	  MTAB(I) = YDIF1/(XTAB(I)-XHAT);
	end;
      end;    
   
      % increment counters
      IM1 = I;
      I = I1;
      I1 = I1 + 1;   
      if (I > NUM1) 

	break;
      end;

      % Calculate the slopes of the two lines joining three consecutive
      % data points.
      YDIF1 = YTAB(I) - YTAB(IM1);
      YDIF2 = YTAB(I1) - YTAB(I);
      M1 = YDIF1/(XTAB(I)-XTAB(IM1));
      M2 = YDIF2/(XTAB(I1)-XTAB(I));
      
    end;

    % Calculate the slope at the last point, XTAB(NUM).
   if ((M1*M2)>=0) 

      XMID = (XTAB(NUM1)+XTAB(NUM))/2;
      YXMID = MTAB(NUM1)*(XMID-XTAB(NUM1)) + YTAB(NUM1);
      MTAB(NUM) = (YTAB(NUM)-YXMID)/(XTAB(NUM)-XMID);
      
      if ((MTAB(NUM)*M2)<0) 

	MTAB(NUM)=0;
      end;
   else
     MTAB(NUM) = 2*M2;
   end;

   % Calculate the slope at the first point, XTAB(1).
   if ((M1S*M2S)<0) 

     MTAB(1)=2*M1S;
   else
     XMID = (XTAB(1)+XTAB(2))/2;
     YXMID = MTAB(2)*(XMID-XTAB(2)) + YTAB(2);
     MTAB(1) = (YXMID-YTAB(1))/(XMID-XTAB(1));
     if ((MTAB(1)*M1S)<0) 

       MTAB(1) =0;
     end;
   end;
end  