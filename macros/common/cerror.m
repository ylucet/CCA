% All CCA functions should use this function instead of error(),
% so that we can act differently depending on when we're generating
% an error to pass a test or generating one for real.  Currently
% this function could be eliminated by having __testing_errors = 9999
% in test.sci:errorTestWrapper(), but this way presents more flexibility.
function cerror(msg)
  global testing_errors;
  if (testing_errors) 
    error(msg, testing_errors);
  else
    error(msg);
  end;
end