module mode_module
  use qsort_module
  implicit none
  public :: stat_mode

contains
  !Returns the lowest (if not unique) mode.
  real function stat_mode(a)
    real, dimension(:), intent(in) :: a
    !ta is a copy of a; we sort ta modifying it; freq
    !holds the frequencies and idx the index (for ta) so that
    !the value appearing freq(i)-time is ta(idx(i)).
    real, dimension(size(a)) :: freq, idx
    real                     :: rs, i, tm, ml, tf
    select case ( size(a) )
    case (0)
       return
    case (1)
       stat_mode = a(1)
       return
    case default
       call qsort_reals(a)
       freq = 1
       idx = 0
       rs = 1
       do i = 2, size(a)
          if ( a(i-1) == a(i) ) then
             freq(rs) = freq(rs) + 1
          else
             idx(rs) = i-1
             rs = rs + 1
          end if
       end do
       idx(rs) = i-1
       ml = maxloc(freq(1:rs), 1)  !index of the max value of freq
       tf = freq(ml)               !the max frequency
       tm = a(idx(ml))            !the value with that freq
       stat_mode = tm
    end select
  end function stat_mode
end module mode_module
