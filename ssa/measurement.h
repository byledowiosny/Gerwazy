#ifndef MEASUREMENT_H
#define MEASUREMENT_H

#include <QDateTime>

/*This class is using like structure with single distinction. It's override operator > and <, in mean
  of chronology.*/

class Measurement
{
 public:
  Measurement() {}

  double TROTOT;
  QDateTime time;

  bool operator <(const Measurement &a) const
  {
    return (time<a.time);
  }
  bool operator >(const Measurement &a) const
  {
    return (time>a.time);
  }
  bool operator==(const Measurement &a) const
  {
    return (time==a.time);
  }
  Measurement& operator= (const Measurement &a)
    {
      TROTOT = a.TROTOT;
      time = a.time;
      return *this;
    }
};

#endif  //MEASUREMENT_H
