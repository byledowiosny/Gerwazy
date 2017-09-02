!Module holding all the data types.
module DATA_MODULE
  type REAL_DATA
     real :: value
  end type REAL_DATA
  type(REAL_DATA), parameter :: empty_data = REAL_DATA(-999.0)
end module DATA_MODULE

!Module defining the vector type.
module REAL_VECTORS
  use DATA_MODULE, VECTOR_DATA => REAL_DATA, &
       empty_vector_data => empty_data
  include "vectors.f90"
end module REAL_VECTORS

program mode_high_low
  use readline_module
  use welcome_module
  use REAL_VECTORS
  use mode_module
  implicit none
  type(VECTOR)      :: v_tick
  !real(8)           :: tick
  type(VECTOR_DATA) :: tick
  integer           :: size
  integer                       :: lun
  logical                       :: success
  character(len=:), allocatable :: line
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
  integer :: time, start_time, tick_time
  real(8) :: volume, sigma_volume

  call welcome()

  lun = 10
  open( lun, file =  year//'-'//month//'-TTV.dat')
  open(unit=30, file = year//'-'//month//'-SMHLW.dat', status='replace')
  STR         = year//'-'//month//
  CALL STR2ET ( STR, ET )  !Input time converts to ET (sec past J2000).
  start_time = nint(ET)
  time = start_time
  call vector_create( v_tick )
  do
     call readline( lun, line, success )
     if ( .not. success ) then
        exit
     endif
     read(line, *) ET, tick, volume  !Internal read, for converting from string to float
     tick_time = nint(ET)
     if (tick_time .eq. time) then
        call vector_append( v_tick, tick )
        sigma_volume = sigma_volume + volume
     elseif (tick_time .gt. time) then
        size = call vector_size( v_tick )
        if (size > 1) then
           !=========================================================================
           write(30,200) time, call stat_mode(v_tick), max(v_tick), min(v_tick), sigma_volume
           !=========================================================================
           time = tick_time
           call vector_delete_elements( v_tick, 1, size )
        endif
     endif
     deallocate( line )
  enddo
  close(30)
200 format(i9," ",3f7.5," ",f5.3)
end program mode_high_low
