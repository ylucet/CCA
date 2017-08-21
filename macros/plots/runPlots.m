function runPlots()

    %%%%%% NOTES %%%%%%
    % In gph_plot, the subfunctions _gph_yCoord, _gph_extendGph, and
    % _gph_plotbounds are called. Each of these have been translated and
    % are working.
    %
    % Currently in the Scilab documentation there is no example for
    % plq_plotpa_muSet, however that should work properly due to fact that
    % its code is incredibly similar to plq_plotpa_lambdaSet, which does
    % work properly.
    %
    %The function plq_plotic also has no documentation, however it is
    %translated and should work as it runs with plq_plotMultiple, which
    %works as is demonstrated below
    %
    %The functions plq_plotpa, plq_plotgpa, and plq_plotka all depend on
    %the function _plq_plotEnv, which is translated but still being
    %de-bugged. There was no matlab equivalent to the scilab function
    %xs2gif(), so a work around was attmepted, however it is still being
    %debugged. Once _plq_plot_Env is working, the three previously mentioned
    %functions will also work, as they are simply wrapper functions. 
    %
    %The plq_plotpa portion of _plq_plotEnv works, as is demonstrated below
    %
    %plq_plotka,  have no example in scilab that I could
    %find to compare to.
    %




    %EXAMPLE FOR PLOT MULTIPLE
    figure
    f1 = [-1,0,-1,-1;0,0,1,1;1,0,-1,1;inf,0,1,-1];  
    f2 = [-1,-3,-12,-9;1,4,0,-4;inf,-3,12,-9];      
    f3 = [0,-3,-18,-29;3,0,-2,-30;inf,0,40,-156];
    plq_plotMultiple(-4, 4, f1, f2, f3);
    title("PLQ Plot Multiple");
    
    % EXAMPLE FOR PLQ PLOT PROXIMAL AVERAGE LAMBDA SET
    figure
    f1 = [2,0,2,-4; inf,0,0,0];
    f2 = [-3,0,30,90; 0,0,0,0; inf,1,0,0];
    plq_plotpa_lambdaSet(f1, f2, -20:0.01:10, 0:0.05:1, 0.2, [-20,-20,10,40]);
    title("PLQ Plot PA Lambda Set");
    
    % EXAMPLES FOR PLQ PLOT
    figure
    % Plotting two functions with a specific grid:
    plqf1 = [-1,0,-1,-1;0,0,1,1;1,0,-1,1;inf,0,1,-1];  % The function abs(abs(x) - 1)
    plqf2 = [-1,-3,-12,-9;1,4,0,-4;inf,-3,12,-9];      % An "m"
    plq_plot(plqf1, plqf2, -4, 4);
    title("PLQ plot: two functions");
    
    figure
    % Plotting a single, noncontinuous function:
    plqf = [0,-3,-18,-29;3,0,-2,6;inf,0,40,-170];
    plq_plot(plqf);
    title("PLQ Plot: single function");
    
    
    % EXAMPLE FOR GPH PLOT
    figure
    gph1 = [-1,  0, 0, 1, 2;  -1, -1, 0, 0, 2;  1,  0, 0, 0, 1];
    gph2 = [ 0.5, 0.5,   1; -1,   1,   1; inf,   5, 5.5];

	% Plot the GPH subdifferentials.
    gph_plot(gph1, gph2);
    title("GPH Plot: Subdifferentials");
    
    %Plot the GPH functions
    
    %NOTE: ERROR IN PLQ_GPH TRANSLATION, line 10: Expression or statement is incorrect--possibly unbalanced (, {, or [.
    %figure
    %plq_plot(plq_gph(gph1), plq_gph(gph2));
    %title("GPH Plot: Functions");
    
    %ECAMPLE FOR PLQ PLOT PROXIMAL AVERAGE
    figure
    plqf1 = [2,1,0,0;inf,0,0,inf];
    plqf2 = [3,0,0,inf;4,0,-1,4;inf,0,1,-4];
    x = linspace(-3, 7, 100)'; lset = 0:0.01:1; rect = [-3,0,7,10];
    plq_plotpa(plqf1, plqf2, x, lset, rect);
    title("PLQ Plot PA using plq-plotEnv");
    

end