module exist_module
  implicit none
  character(len=40) :: the_file
  public :: file_exists

program file_exists(the_file)
  logical :: file_exists
  inquire( file=the_file, exist=file_exists )
  if ( file_exists ) then
     write(*,*) "Yes, "the_file" exists!"
  else
     write(*,*) "No, "the_file" doesn't exist!"
     !call system('touch "dupa_zbita.dat"')
  end if
end program file_exists

end module exist_module
!logical :: dir_exists
!inquire( file="./docs/.", exist=dir_exists )
!if ( dir_exists ) then
!write(*,*) "Yes, dir exists!"
!else
!write(*,*) "No, dir doesn't exist!"
!call system('mkdir docs')
!end if
