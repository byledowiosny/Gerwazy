program histogram
  use fgsl
  use welcome_module
  use ticks_module
  implicit none
  real(fgsl_double) :: a, b, x
  integer(fgsl_size_t) :: n
  integer(fgsl_int) :: status
  integer :: i
  type(fgsl_histogram) :: h
  type(fgsl_file) :: stdout

  call ticks()

  namelist / histpar / a, b, n

  write(*, *) 'Reading histogram parameters from file histogram.dat ... '
  open(20, file='histogram.dat', form='formatted', status='old')
  read(20, nml=histpar)
  close(20)
  stdout = fgsl_stdout()
  h = fgsl_histogram_alloc(n)
  status = fgsl_histogram_set_ranges_uniform(h, a, b)

  time = start_time

  open(20, file=year//'-'//month//'-TTV.dat', status='old')
  open(30, file = year//'-'//month//'-MMHLV.dat', status='replace')
  do
     call readline( 20, line, success )

     if ( .not. success ) then
        exit
     endif

     !Internal read, for converting from string to float
     read(line, fmt='(I9,F7.5,F7.2)') tick_second, x, volume
     if (high_frequency == 1) then
        if (time < tick_second) then  !for first pass
           time = tick_second
        endif
        status = fgsl_histogram_increment (h, x)
        sigma_volume = sigma_volume + volume
        if (tick_second .gt. time) then
           mode_tick = gsl_histogram_max_val (h)
           max_tick = fgsl_histogram_max (h)
           min_tick = fgsl_histogram_min (h)
           write(30,200) time, mode_tick, max_tick, min_tick, sigma_volume
           time = tick_second
           !empty histogram
        endif
     elseif (high_frequency == 2) then
        tick_minute = nint(tick_second/60)
        !...
     elseif (high_frequency == 3) then
        tick_hour = nint(tick_second/3600)
        !...
     elseif (high_frequency == 4) then
        tick_day = nint(tick_second/86400)
        !...
     else
        mode_tick = gsl_histogram_max_val (h)
        max_tick = fgsl_histogram_max (h)
        min_tick = fgsl_histogram_min (h)
        write(30,200) month, mode_tick, max_tick, min_tick, sigma_volume
     endif

  end do
  close(20)
  close(30)
  call fgsl_histogram_free(h)
200 format(A2," ",3F7.5" ",F7.2)
end program histogram
