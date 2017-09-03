program histogram
  use fgsl
  use welcome_module
  use ticks_module
  implicit none
  real(fgsl_double) :: a, b, x, volume, sigma_volume, max_tick, min_tick
  integer(fgsl_size_t) :: n
  integer(fgsl_int) :: status
  integer :: i, time_second, time_minute, time_hour, time_day
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

  time_second = start_time
  time_minute = nint(time_second/60)
  time_hour = nint(time_second/3600)
  time_day = nint(time_second/86400)

  open(20, file=year//'-'//month//'-TTV.dat', status='old')
  open(30, file = year//'-'//month//'-MMHLV.dat', status='replace')
  do
     call readline( 20, line, success )

     if ( .not. success ) then
        exit
     endif

     !Internal read, for converting from string to float
     read(line, fmt='(I9,F7.5,F7.2)') tick_second, x, volume
     if (frequency == 1) then
        if (time_second < tick_second) then  !for first pass
           time_second = tick_second
        endif
        status = fgsl_histogram_increment (h, x)
        sigma_volume = sigma_volume + volume
        if (tick_second .gt. time_second) then
           mode_tick = fgsl_histogram_max_val (h)
           max_tick = fgsl_histogram_max (h)
           min_tick = fgsl_histogram_min (h)
           write(30,200) time_second, mode_tick, max_tick, min_tick, sigma_volume
           time_second = tick_second
           fgsl_histogram_reset (h)
        endif
     elseif (frequency == 2) then
        tick_minute = nint(tick_second/60)
        if (time_minute < tick_minute) then  !for first pass
           time_minute = tick_minute
        endif
        status = fgsl_histogram_increment (h, x)
        sigma_volume = sigma_volume + volume
        if (tick_minute .gt. time_minute) then
           mode_tick = fgsl_histogram_max_val (h)
           max_tick = fgsl_histogram_max (h)
           min_tick = fgsl_histogram_min (h)
           write(30,200) time_minute, mode_tick, max_tick, min_tick, sigma_volume
           time_minute = tick_minute
           fgsl_histogram_reset (h)
        endif
     elseif (frequency == 3) then
        tick_hour = nint(tick_second/3600)
        if (time_hour < tick_hour) then  !for first pass
           time_hour = tick_hour
        endif
        status = fgsl_histogram_increment (h, x)
        sigma_volume = sigma_volume + volume
        if (tick_hour .gt. time_hour) then
           mode_tick = fgsl_histogram_max_val (h)
           max_tick = fgsl_histogram_max (h)
           min_tick = fgsl_histogram_min (h)
           write(30,200) time_hour, mode_tick, max_tick, min_tick, sigma_volume
           time_hour = tick_hour
           fgsl_histogram_reset (h)
        endif
     elseif (frequency == 4) then
        tick_day = nint(tick_second/86400)
        if (time_day < tick_day) then  !for first pass
           time_day = tick_day
        endif
        status = fgsl_histogram_increment (h, x)
        sigma_volume = sigma_volume + volume
        if (tick_day .gt. time_day) then
           mode_tick = fgsl_histogram_max_val (h)
           max_tick = fgsl_histogram_max (h)
           min_tick = fgsl_histogram_min (h)
           write(30,200) time_day, mode_tick, max_tick, min_tick, sigma_volume
           time_day = tick_day
           fgsl_histogram_reset (h)
        endif
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
