module readline_module
  use iso_fortran_env
  implicit none
contains
  subroutine readline( lun, line, success )
    integer, intent(in)                        :: lun
    character(len=:), allocatable, intent(out) :: line
    logical, intent(out)                       :: success
    character(len=0)                           :: newline
    success = .true.
    call readline_piece_by_piece( newline )
  contains
    recursive subroutine readline_piece_by_piece( newline )
      character(len=*)                :: newline
      character(len=10)               :: piece
      integer                         :: ierr
      integer                         :: sz
      read( lun, '(a)', advance = 'no', size = sz, iostat = ierr ) piece
      if ( ierr /= 0 .and. ierr /= iostat_eor  ) then
         allocate( character(len=len(newline)):: line )
         line = newline
         success = .false.
         return
      endif
      !Have we gotten to the end of the line or not?
      if ( sz >= len(piece)  ) then
         call readline_piece_by_piece( newline // piece )
      else
         allocate( character(len=len(newline)+sz):: line )
         line = newline // piece(1:sz)
         success = .true.
      endif
    end subroutine readline_piece_by_piece
  end subroutine readline
end module readline_module