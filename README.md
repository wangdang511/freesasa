FreeSASA
=======

C-library for calculating Solvent Accessible Surface Areas.

License: GPLv3 (see file COPYING). Copyright: Simon Mitternacht 2013-2014.

So far the algorithms by Lee & Richards and Shrake & Rupley have been
implemented. Verification has been done by comparing the results of
the two calculations and by visual inspection of the surfaces found by
them (and comparing with analytic results in the two-atom case). For
high resolution versions of the algorithms, the calculations give
identical results.

The OONS atom-classification and radii are used by default (Ooi et al.
PNAS 1987). Users can also provide their own atomic radii.

Has been tested successfully with several versions of GNU C Compiler
and Clang/LLVM. Building the library only requires standard C and GNU libraries. 
Developers who want to do testing need to install the Check unit testing framework.

Can be compiled and installed using the following

    ./configure
    make && make install

The program freesasa provides a command-line interface, the command
`freesasa -h` gives an overview of options. If downloaded from the
git repository the configure-script needs to be set up first using 
`autoreconf -i`.

Profiling has shown that configuring with 

    ./configure CFLAGS='-ffast-math -funroll-loops -O3' 

increases the speed of the Shrake & Rupley algorithm significantly (10
% or so), as compared to the standard "-O2". There seems to be no
measurable effect on Lee & Richards.

