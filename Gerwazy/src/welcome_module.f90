module welcome_module
  use chdir_module
  implicit none
  private
  integer:: asset, high_low
  character(len=4) :: year_start, year_end
  integer:: io

  public :: welcome
  character(len=4), public :: year
  character(len=2), public :: month
  integer, public :: nlines, frequency

contains
  subroutine welcome()
    print*, 'Welcome to Gerwazy, time series analysis.'
    print*, 'The base time series are the millisecond ticks data from Dukascopy Bank, CH:'
    print*, '"Time "(UTC), Ask, Bid, AskVolume, BidVolume"'
    print*, 'The assets was pre-selected for high volatility and liquidity.'
    print*, 'Choose the number:'
    print*, '1 - EURUSD'
    print*, '2 - GBPUSD'
    print*, '3 - EURJPY'
    read*, asset
    if (asset .eq. 1) then
       call chdir("/home/jerzy/calculus/data/EURUSD/")
    elseif (asset .eq. 2) then
       call chdir("/home/jerzy/calculus/data/GBPUSD/")
    elseif (asset .eq. 3) then
       call chdir("/home/jerzy/calculus/data/EURJPY/")
    else
       print*, 'The number must be equal 1,2 or 3! Please, try again.'
    endif

    print*, 'The time series are arbitrarily ranged from high to low frequency.'
    print*, 'Choose the number:'
    print*, '1 - Second'
    print*, '2 - Minute'
    print*, '3 - Hour'
    print*, '4 - Day'
    print*, '5 - Week'
    print*, '6 - Month'
    read*, frequency
    if (frequency .lt. 7) then
       print*, 'Enter the year and month (yyyy mm):'
       read*, year, month
       call chdir(year//'/'//month//'/')
       call count_lines()
    else
       print*, 'The number must be equal 1,2,3,4,5 or 6! Please, try again.'
    endif
  end subroutine welcome

  subroutine count_lines()
    open(40,file=year//'-'//month//'-Ticks.csv', iostat=io, status='old')
    if (io/=0) stop 'Cannot open file! '
    nlines = 0
    do
       read(40,*,iostat=io)
       if (io/=0) exit
       nlines = nlines + 1
    end do
    close(40)
    print*, 'nlines=', nlines
  end subroutine count_lines

end module welcome_module
