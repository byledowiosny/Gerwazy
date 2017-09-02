module ticks_module
  use readline_module
  use parse_module
  use welcome_module
  logical                       :: success
  character(len=:), allocatable :: line
  real(8)                       :: ask
  real(8)                       :: bid
  character(7)                  :: askV
  character(7)                  :: bidV
  integer                       :: tick_time, tick_diff
  INTEGER               FILEN
  PARAMETER           ( FILEN = 128 )
  INTEGER               LNSIZE
  PARAMETER           ( LNSIZE = 60 )
  CHARACTER*(FILEN)     KERNEL
  CHARACTER*(LNSIZE)    STR
  DOUBLE PRECISION      ET

  public :: ticks
  integer, public :: start_time
  real(8), public :: tick_min, tick_max

contains
  subroutine ticks()
    KERNEL = '../../time/data/naif0012.tls'
    CALL FURNSH ( KERNEL )
    STR         = year//'-'//month//
    CALL STR2ET ( STR, ET )  !Input time converts to ET (sec past J2000).
    start_time = nint(ET)

    call welcome()

    open( 10, file =  year//'-'//month//'-Ticks.csv')
    open( 30, file = year//'-'//month//'-TTV.dat', status='replace')
    do
       call readline( lun, line, success )
       if ( .not. success ) then
          exit
       endif
       if (len(line) > 40) then  !no headers
          parse_line = line
          STR         = getArg(1)
          CALL STR2ET ( STR, ET )  !Input time converts to ET (sec past J2000).
          tick_time = nint(ET)
          read(getArg(2), fmt='(F7.5)') ask
          read(getArg(3), fmt='(F7.5)') bid
          askV        = getArg(4)
          bidV        = getArg(5)
          if (ask > tick_max) then
             tick_max = ask
          elseif (bid > tick_max)
             tick_max = bid
          endif
          if (ask < tick_min) then
             tick_min = ask
          elseif (bid < tick_min)
             tick_min = bid
          endif
          tick_diff = nint(tick_max - tick_min)*10000
          !=======================================================================
          write(30,200) tick_time, ask, askV
          write(30,200) tick_time, bid, bidV
          !=======================================================================
          deallocate( line )
       endif
    enddo
    open(20, file="histogram.dat", status='replace')
    write(20,*) "&histpar a=",tick_min,", b=",tick_max,", n=",tick_diff," /"
    close(10)
    close(20)
    close(30)
200 format(i9," ",f7.5," ",a7)
  end subroutine ticks()
end module ticks_module
