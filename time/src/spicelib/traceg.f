C$Procedure  TRACEG ( Trace of a matrix, general dimension )
 
      DOUBLE PRECISION FUNCTION  TRACEG ( MATRIX, NDIM )
 
C$ Abstract
C
C      Return the trace of a square matrix of arbitrary dimension.
C
C$ Disclaimer
C
C     THIS SOFTWARE AND ANY RELATED MATERIALS WERE CREATED BY THE
C     CALIFORNIA INSTITUTE OF TECHNOLOGY (CALTECH) UNDER A U.S.
C     GOVERNMENT CONTRACT WITH THE NATIONAL AERONAUTICS AND SPACE
C     ADMINISTRATION (NASA). THE SOFTWARE IS TECHNOLOGY AND SOFTWARE
C     PUBLICLY AVAILABLE UNDER U.S. EXPORT LAWS AND IS PROVIDED "AS-IS"
C     TO THE RECIPIENT WITHOUT WARRANTY OF ANY KIND, INCLUDING ANY
C     WARRANTIES OF PERFORMANCE OR MERCHANTABILITY OR FITNESS FOR A
C     PARTICULAR USE OR PURPOSE (AS SET FORTH IN UNITED STATES UCC
C     SECTIONS 2312-2313) OR FOR ANY PURPOSE WHATSOEVER, FOR THE
C     SOFTWARE AND RELATED MATERIALS, HOWEVER USED.
C
C     IN NO EVENT SHALL CALTECH, ITS JET PROPULSION LABORATORY, OR NASA
C     BE LIABLE FOR ANY DAMAGES AND/OR COSTS, INCLUDING, BUT NOT
C     LIMITED TO, INCIDENTAL OR CONSEQUENTIAL DAMAGES OF ANY KIND,
C     INCLUDING ECONOMIC DAMAGE OR INJURY TO PROPERTY AND LOST PROFITS,
C     REGARDLESS OF WHETHER CALTECH, JPL, OR NASA BE ADVISED, HAVE
C     REASON TO KNOW, OR, IN FACT, SHALL KNOW OF THE POSSIBILITY.
C
C     RECIPIENT BEARS ALL RISK RELATING TO QUALITY AND PERFORMANCE OF
C     THE SOFTWARE AND ANY RELATED MATERIALS, AND AGREES TO INDEMNIFY
C     CALTECH AND NASA FOR ALL THIRD-PARTY CLAIMS RESULTING FROM THE
C     ACTIONS OF RECIPIENT IN THE USE OF THE SOFTWARE.
C
C$ Required_Reading
C
C     None.
C
C$ Keywords
C
C      MATRIX
C
C$ Declarations
 
      INTEGER            NDIM
      DOUBLE PRECISION   MATRIX ( NDIM,NDIM )
 
C$ Brief_I/O
C
C      VARIABLE  I/O  DESCRIPTION
C      --------  ---  --------------------------------------------------
C      MATRIX     I     NDIM x NDIM matrix of double precision numbers.
C      NDIM       I     Dimension of the matrix.
C      TRACEG     O     The trace of MATRIX.
C
C$ Detailed_Input
C
C      MATRIX  is a double precision square matrix of arbitrary
C              dimension.  The input matrix must be square or else
C              the concept is meaningless.
C
C      NDIM    is the dimension of MATRIX.
C
C$ Detailed_Output
C
C      TRACEG  is the trace of MATRIX, i.e. it is the sum of the
C              diagonal elements of MATRIX.
C
C$ Parameters
C
C     None.
C
C$ Particulars
C
C      TRACEG simply executes in FORTRAN code the following loop:
C
C      TRACEG = Summation from I = 1 to NDIM of MATRIX(I,I)
C
C      No error detection or correction is implemented within this
C      function.
C
C$ Examples
C
C                            | 3   5   7 |
C      Suppose that MATRIX = | 0  -2   8 |  (with NDIM = 3), then
C                            | 3   0  -1 |
C
C      TRACEG (MATRIX, 3) = 0.  (which is the sum of 3, -2 and -1).
C
C$ Restrictions
C
C      No checking is performed to guard against floating point overflow
C      or underflow.  This routine should probably not be used if the
C      input matrix is expected to have large double precision numbers
C      along the diagonal.
C
C$ Exceptions
C
C      Error free.
C
C$ Files
C
C      None.
C
C$ Author_and_Institution
C
C      W.L. Taber      (JPL)
C
C$ Literature_References
C
C      None.
C
C$ Version
C
C-     SPICELIB Version 1.0.1, 10-MAR-1992 (WLT)
C
C         Comment section for permuted index source lines was added
C         following the header.
C
C-     SPICELIB Version 1.0.0, 31-JAN-1990 (WLT)
C
C-&
 
C$ Index_Entries
C
C     trace of a nxn_matrix
C
C-&
 
      INTEGER         I
 
      TRACEG = 0.0D0
      DO I = 1,NDIM
         TRACEG = TRACEG + MATRIX(I,I)
      END DO
 
      RETURN
      END
