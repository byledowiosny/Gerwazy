module parse_module
  integer, parameter :: MAX_LINE = 60  !determine the size of line
  character(MAX_LINE) :: parse_line
contains
  function getArg(n) result(arg)
    implicit none
    character(MAX_LINE) :: arg
    integer :: n,i,j,count
    j = 0
    do count=1,n
       i = j + 1
       j = INDEX(parse_line(i:),',')
       if(j == 0) exit
       j = j + i - 1
    end do
    if(j == 0) then
       if(count == n) then
          arg = parse_line(i:)
       else
          arg = ' '
       endif
    else
       arg = parse_line(i:j-1)
    endif
  end function getArg
end module parse_module

program gerwazy
  use readline_module
  use parse_module
  use welcome_module
  integer                       :: lun
  logical                       :: success
  character(len=:), allocatable :: line
  !CHARACTER(LEN = 23)  :: time_string
  !real(8)              :: ask
  character(7)         :: ask
  !real(8)              :: bid
  character(7)         :: bid
  !real(8)              :: askV
  character(7)         :: askV
  !real(8)              :: bidV
  character(7)         :: bidV
  INTEGER               FILEN
  PARAMETER           ( FILEN = 128 )
  INTEGER               LNSIZE
  PARAMETER           ( LNSIZE = 60 )
  CHARACTER*(FILEN)     KERNEL
  CHARACTER*(LNSIZE)    STR
  DOUBLE PRECISION      ET
  !KERNEL = 'naif0012.tls'
  KERNEL = '../../time/data/naif0012.tls'
  CALL FURNSH ( KERNEL )
  
  call welcome()

  lun = 10
  !open( lun, file = '2016-01-Ticks.csv' )
  open( lun, file =  year//'-'//month//'-Ticks.csv')
  open(unit=30, file = year//'-'//month//'-TTV.dat', status='replace')
  do
     call readline( lun, line, success )
     if ( .not. success ) then
        exit
     endif
     if (len(line) > 40) then  !no headers
        parse_line = line
        !time_string = getArg(1)
        STR         = getArg(1)
        CALL STR2ET ( STR, ET )  !Input time converts to ET (sec past J2000).
        ask         = getArg(2)
        bid         = getArg(3)
        askV        = getArg(4)
        bidV        = getArg(5)
        !write(*,*) ET, ' ', ask, ' ', askV
        !write(*,*) ET, ' ', bid, ' ', bidV
        !=======================================================================
        write(30,200) ET, ask, askV
        write(30,200) ET, bid, bidV
        !=======================================================================
        deallocate( line )
     endif
  enddo
  close(30)
200 format(f18.8," ",a7," ",a7)
end program gerwazy
