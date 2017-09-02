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
