% _soqs_choose
%
% Auxillary function for _soqs_build to determine the type of spline
% regarding derivative slopes and distances between the spline end points.
%
% The code is taken partially from Algorithm 574: Shape-Preserving
% Osculatory Quadratic Splines, Feb. 4, 1981 with permission from the
% Association for Computing Machinery (ACM).
function NCASE=soqs_choose(P1,P2,M1,M2,Q1,Q2,eps)
  
            % Initialization
            PROD=0;
            PROD1=0;
            PROD2=0;
            MREF=0;
            MREF1=0;
            MREF2=0;
            NCASE=0;
            
	    % Calculate the slope SPQ if the line joining (P1,P2),(Q1,Q2)
            SPQ = (Q2-P2)/(Q1-P1);

            if SPQ==0 

                  if M1*M2<0 

                        NCASE=1;
                  else
                        NCASE=2;
                  end;
                  return;
            else
                  PROD1=SPQ*M1;
                  PROD2=SPQ*M2;
                  MREF=abs(SPQ);
                  MREF1=abs(M1);
                  MREF2=abs(M2);
                  
		  % if the relative deviation of M1 or M2 from SPQ is
                  % less than eps, then choose case 2 or case 3.
                  if ((abs(SPQ-M1)>eps*MREF)&(abs(SPQ-M2)>eps*MREF)) 

                  
                        if (PROD1>=0 & PROD2>=0) 

                              PROD=(MREF-MREF1)*(MREF-MREF2);
                              if (PROD<0) 

				    % L1 and L2 intersect inside [P1,Q1]
                                    NCASE=1;
                                    return;
                              end;
                        end;
                  end;
            
                  if ((PROD1 < 0)|(PROD2 < 0)) 

		        % the sign of at least one of the slopes M1,M2
                        % does not agree with the sign of the slope SPQ
                        if (PROD1 < 0) & (PROD2 < 0) 

                              NCASE=2;
                              return;
                        end;
                        if (PROD1 < 0) 


                              if (MREF2 > (1+eps)*MREF) 

                                    NCASE=1;
                              else
                                    NCASE=2;
                              end;
                              return;
                        else
                              if (MREF1 > (1+eps)*MREF) 

                                    NCASE=1;
                              else
                                    NCASE=2;
                              end;
                              return;
                        end;
                  end;
            
                  if (MREF1 > 2*MREF) 

                        if (MREF2 > (2-eps)*MREF) 

                              NCASE=4;
                        else
                              NCASE=3;
                        end;
                        return;
                  end;
            
                  if (MREF2 > 2*MREF) 

                        if (MREF1 > (2-eps)*MREF) 

                              NCASE=4;
                        else
                              NCASE=3;
                        end;
                        return;
                  end;
            
                  NCASE=2;
                  return;
                              
            end;
      
end