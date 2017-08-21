function version = plq_version()
      version = '1.7.0';
      % 1.5.4 -> 1.5.5
      %fixed a bug in plq_oploop due to roundoff errors (added eps and approximate tests)

      % Scilab tacitly assumes that file foo.sci defines at least a function named foo. 
      % If subsidiary functions are included, they are made known to Scilab only after 
      % the function foo had been referenced.

      % This function initializes the global variable
      % __sci_version which contains the major scilab number. 
      end
























