function version = common_version()
      version = '1.7.0';
      % 1.5.5 -> 1.5.6
      % - added _removeTriplicate
      % - added epsUnique
      % - fixed bug in isEqual2
      % - added intervalIntersect
      %
      % 1.5.4 -> 1.5.5
      % - Renamed file to common_version.sci.
      % - Added global __sci_version variable.
      % 1.5.3 -> 1.5.4
      % - Created common.sci.
      % - Moved checksize, {row,col}Map from me.sci.
      % - Added progress bar code (was originally in demos/demo.sci).
      % - Added custom error code (cerror).
      % - Added an isEqual function to compare equality of multiple matrices easily.
      % - Added a sumFinites to sum the finite numbers in a (hyper)matrix.
      
      % Scilab tacitly assumes that file foo.sci defines at least a function named foo. 
      % If subsidiary functions are included, they are made known to Scilab only after 
      % the function foo had been referenced.
      
end
