Almost Sorted
=============

Challenge: https://www.hackerrank.com/challenges/almost-sorted/


Notes
-----

Interesting little problem, seems though and filled with corner cases
until I actually wrote out a few scenarios.  There's definitely sneaker
ways to solve this, and there is some obvious room for optimization in
the initial order check.  Spider-sense suggests there's a few cases I
didn't catch, but it passes the challenge.

The basic algorithm, as implemented:

* Find any anomalies in the data
* If none, it's ordered
* If one, attempt to swap it and its neighbor
* If two and not neighbors, attempt to swap them
* Otherwise, check if:
  * Anomaly range is continuous
  * In reverse order,
  * Fits with the values before and after the range

More indepth:

* Record lower bound values for in-order, starting outside the element
  range (< 0)
* Go over each element:
  * If the element is less than the lower bound, it is considered
    an anomaly
  * Otherwise, if the element is less than the previous, the previous
    is an anomaly
  * Otherwise, update the lower bound with the previous element
* If no anomalies, data set is ordered
* If one anomaly, check if anomaly, anomaly + 1 can be swapped
* If two anomalies, check if they can be swapped if they are
  non-continuous
* Otherwise, check if it can be reversed, starting from the first anomaly,
  to the last anomaly+1
  * If anomalies are non-continuous, cannot be reversed
  * If anomaly range is not in reverse order, cannot be reversed
  * If the last value in the range is less than the value before the
    start of the anomaly, cannot be reversed
  * If the first value in the range is greater than the value after the
    end of the anomaly, cannot be reversed
  * Otherwise, can be reversed
