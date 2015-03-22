#include <iostream>
#include <cmath>

using namespace std;

class Point {
  int x, y;
public :
  Point(int, int);
  ~Point();
  int getx();
  int gety();
};

Point::Point(int m_x, int m_y)
{
  x = m_x;
  y = m_y;
}

Point::~Point()
{
}

int Point::getx()
{
  return x;
}

int Point::gety()
{
  return y;
}

int main(void)
{
  Point pt1[2]={(0,0),(0,1)};

  return 0;
}