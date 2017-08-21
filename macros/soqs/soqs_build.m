% _soqs_build
%
% Builds a Shape-Preserving Osculatory Quadratic Spline (soqs) going
% through (x,f(x)) with derivative df(x) at (x,f(x)).
%
% The code is taken partially from Algorithm 574: Shape-Preserving
% Osculatory Quadratic Splines, Feb. 4, 1981 with permission from the
% Association for Computing Machinery (ACM).
%x, f, df are vectors such that f=f(x) and df=f'(x)
%extrapolate: take values: 'constant': extrapolate by a constant, 
%            'bounded': bounded domain (extrapolate by inf)
function spline=soqs_build(x,f,df,extrapolate)
      n=max(size(x));
      spline(1,:)=[x(1),0,0,f(1)];%constant extrapolation
      
      for i=1:n-1;
            M1=df(i);
            M2=df(i+1);
            P1=x(i);
            P2=f(i);
            Q1=x(i+1);
            Q2=f(i+1);

            % Determine the case
            Case=soqs_choose(P1,P2,M1,M2,Q1,Q2,2.20D-16); 
            % Calculate parameters
            Z1=0;
            ZTWO=0;
            V1=0;
            V2=0;
            W1=0;
            W2=0;
            Z2=0;
            
            if Case==1 
 
                  Z1=(P2-Q2+M2*Q1-M1*P1)/(M2-M1);
                  ZTWO = P2 + M1*(Z1-P1);
                  V1 = (P1+Z1)/2;
                  V2 = (P2+ZTWO)/2;
                  W1 = (Z1+Q1)/2;
                  W2 = (ZTWO+Q2)/2;
                  Z2 = V2 + ((W2-V2)/(W1-V1))*(Z1-V1);
            elseif Case==2 

                  Z1 = (P1+Q1)/2;
                  V1 = (P1+Z1)/2;
                  V2 = P2 + M1*(V1-P1);
                  W1 = (Z1+Q1)/2;
                  W2 = Q2 + M2*(W1-Q1);
                  Z2 = (V2+W2)/2;
            else
                  C1 = P1 + (Q2-P2)/M1;
                  D1 = Q1 + (P2-Q2)/M2;
                  H1 = 2*C1 - P1;
                  J1 = 2*D1 - Q1;
                  MBAR1 = (Q2-P2)/(H1-P1);
                  MBAR2 = (P2-Q2)/(J1-Q1);
                  
                  if Case==3 

                        K1 = (P2-Q2+Q1*MBAR2-P1*MBAR1)/(MBAR2-MBAR1);
                        if (abs(M1)>abs(M2)) 

                              Z1=(K1+P1)/2;
                        else
                              Z1=(K1+Q1)/2;
                        end;
                        V1 = (P1+Z1)/2;
                        V2 = P2 + M1*(V1-P1);
                        W1 = (Q1+Z1)/2;
                        W2 = Q2 + M2*(W1-Q1);
                        Z2 = V2 + ((W2-V2)/(W1-V1))*(Z1-V1);                        
                  else
                        Y1 = (P1+C1)/2;
                        V1 = (P1+Y1)/2;
                        V2 = M1*(V1-P1) + P2;
                        Z1 = (D1+Q1)/2;
                        W1 = (Q1+Z1)/2;
                        W2 = M2*(W1-Q1) + Q2;
                        MBAR3 = (W2-V2)/(W1-V1);
                        Y2 = MBAR3*(Y1-V1) + V2;
                        Z2 = MBAR3*(Z1-V1) + V2;
                        E1 = (Y1+Z1)/2;
                        E2 = MBAR3*(E1-V1) + V2;
                  end;
            end;
      
            % calculate Bernstein coefficients according to case    
            if Case==1 | Case==2 | Case==3 

                  
                              a=(P2+Z2-2*V2)/(Z1-P1).^2;
                              b=(-2*P2*Z1+2*V2*P1+2*V2*Z1-2*Z2*P1)/(Z1-P1).^2;
                              c=(P2*Z1.^2+Z2*P1.^2-2*V2*P1*Z1)/(Z1-P1).^2;
                              spline(end+1,:)=[Z1,a,b,c];
                        
                              a=(-2*W2+Z2+Q2)/(Q1-Z1).^2';
                              b=(-2*Z2*Q1+2*W2*Z1+2*W2*Q1-2*Q2*Z1)/(Q1-Z1).^2;
                              c=(Z2*Q1.^2+Q2*Z1.^2-2*W2*Z1*Q1)/((Q1-Z1).^2);
                              spline(end+1,:)=[Q1,a,b,c];
                              
            else

                              a=(-2*V2+P2+Y2)/(Y1-P1).^2;
                              b=(-2*P2*Y1+2*V2*P1+2*V2*Y1-2*Y2*P1)/(Y1-P1).^2;
                              c=(P2*Y1.^2+Y2*P1.^2-2*V2*P1*Y1)/(Y1-P1).^2;
                              spline(end+1,:)=[Y1,a,b,c];

                          
                              a=(-2*E2+Y2+Z2)/(Z1-Y1).^2';
                              b=(-2*Y2*Z1+2*E2*Y1+2*E2*Z1-2*Z2*Y1)/(Z1-Y1).^2;
                              c=(Y2*Z1.^2+Z2*Y1.^2-2*E2*Y1*Z1)/((Z1-Y1).^2);
                              spline(end+1,:)=[Z1,a,b,c];
            
                              a=(-2*W2+Z2+Q2)/(Q1-Z1).^2';
                              b=(-2*Z2*Q1+2*W2*Z1+2*W2*Q1-2*Q2*Z1)/(Q1-Z1).^2;
                              c=(Z2*Q1.^2+Q2*Z1.^2-2*W2*Z1*Q1)/((Q1-Z1).^2);
                              spline(end+1,:)=[Q1,a,b,c];
             
            end;
      
      end;
      spline(end+1,:)=[inf,0,0,f(n)];%constant extrapolation

      switch (extrapolate)
        case 'constant' 
%constant outside of domain (nothing to do)
        case 'bounded' 
%bounded domain: inf outside of domain
          spline(1,4)=inf;
          spline(end,4)=inf;
        otherwise         
          cerror(sprintf('Unknown option       end '))
      end
end
