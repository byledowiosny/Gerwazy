#!/bin/bash

#Requires: FoBiS and Ford

MODCODE='gerwazy_module.f90'           # module file name
LIBOUT='libgerwazy.a'               # name of library
DOCDIR='./doc/'                     # build directory for documentation
SRCDIR='./src/'                     # library source directory
PROGSRCDIR='./src/program/'         # program source directory
BINDIR='./bin/'                     # build directory for program
LIBDIR='./lib/'                     # build directory for library
#gfortran program.f ../time/lib/spicelib.a
#pkg-config --libs fgsl
#LIBLOCAL='-L/usr/local/lib -lfgsl -lgsl -lgslcblas -lm'
SPICELIB='../time/lib/spicelib.a'
FORDMD='gerwazy.md'                 # FORD config file name

#Compiler flags:

FCOMPILER='gnu'                    #Set compiler to gfortran
#pkg-config --cflags fgsl
FCOMPILERFLAGS='-c -O2 -std=f2008'
#FCOMPILER='intel'                  #Set compiler to intel
#FCOMPILERFLAGS='-c -O0 -warn -stand f08 -traceback -g'

#Build using FoBiS:

if hash FoBiS.py 2>/dev/null; then

    echo "Building library..."

    FoBiS.py build -compiler ${FCOMPILER} -cflags "${FCOMPILERFLAGS}" -dbld ${LIBDIR} -s ${SRCDIR} -dmod ./ -dobj ./ -t ${MODCODE} -o ${LIBOUT} -mklib static -colors

    echo "Building program..."

    FoBiS.py build -compiler ${FCOMPILER} -cflags "${FCOMPILERFLAGS}" -dbld ${BINDIR} -s ${PROGSRCDIR} -dmod ./ -dobj ./ -colors -libs ${LIBDIR}${LIBOUT} ${SPICELIB} --include ${LIBDIR}

else
    echo "FoBiS.py not found! Cannot build library. Install using: sudo pip install FoBiS.py"
fi

#Build the documentation using FORD:

if hash ford 2>/dev/null; then

    echo "Building documentation..."

    ford ${FORDMD}

else
    echo "Ford not found! Cannot build documentation. Install using: sudo pip install ford"
fi
