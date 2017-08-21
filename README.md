# CCA
Computational Convex Analysis (CCA) numerical library
CCA numerical library for Computational Convex Analysis
    Copyright (C) 2008-2017, Yves Lucet

This toolbox implements functions for convex operations.


Here are the main files provided by the package. 

======
<PATH>
======

README.txt    The present file

plq_version.m
        Operations on Piecewise Linear-Quadratic
        functions, which are represented as matrices.
        Algorithms are included to perform PLQ
        addition, scalar multiplication, evaluation,
        minimization and maximization, projection, and
        inf-convolution and deconvolution, as well as
        compute Fenchel conjugates, Moreau envelopes,
        convex hulls, proximal averages, and Rockafellar
        functions, and restricted Fitzpatrick functions.
        A PLQ approximation of an arbitrary convex
        function can be built.  There are functions to
        plot PLQ functions and their averages.  See help
        plq_function for the complete list of functions.


For more details on the Scilab functions defined in the 
main toolbox files, refer to the help documentation.

============================
Unit Tests: in <PATH>/tests/
============================

runtests('tests')  Matlab script that runs all unit tests and
          displays the results

*_test.m  Unit test files that validate the algorithms
            and provide numerous examples of their
            use. Test files included are:
        plq_*_test.m: Unit tests and examples for
            the PLQ functions provided in plq_test.m.
        plt_test.m: Tests the Parametric Moreau
            Envelope algorithm pl_me_plt, which uses
            the Parametric Legendre Transform.
        rock_test.m: Unit tests for the computation
            of Rockafellar functions.
                Each of the unit test files can be called 
                independently by giving the command 
                  exec "<PATH>/tests/name_of_test.m"; 
                or
                  exec (CCADIR+'/tests/name_of_test.m');
                Then calling:
                  runtest('name_of_test.m')
                will return a true if the tests succeeded,
                false otherwise.
             
========
Credits:
========
See copyright.txt for the list of contributors to this library.
