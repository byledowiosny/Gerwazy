!qsort_module.f90 - Compact implementation of the QuickSort algorithm.
!Note: Because the function uses Fortran 90 features, its interface should be made
!      explicit when using it in an actual program. This is easiest via a module.

module qsort_module
  implicit none
contains
  recursive function qsort_reals( data ) result( sorted )
    real, dimension(:), intent(in) :: data
    real, dimension(1:size(data))  :: sorted
    if ( size(data) > 1 ) then
       sorted = &
            (/ qsort_reals( pack( data(2:), data(2:) > data(1) ) ), &
            data(1),                                             &
            qsort_reals( pack( data(2:), data(2:) <= data(1) ) ) /)
    else
       sorted = data
    endif
  end function qsort_reals
end module qsort_module
