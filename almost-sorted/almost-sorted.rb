#!/usr/bin/env ruby
# Almost Sorted HackerRank Challenge
#
# The MIT License (MIT)
#
# Copyright (c) 2015 Bryan DeGrendel
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
#

DEBUG_PRINT=false

def parse_input
  n = gets.to_i
  data = gets.split.map {|i| i.to_i }

  $stderr.puts "#{n} != #{data.length}" if n != data.length and DEBUG_PRINT
  $stderr.puts "2 <= #{n} <= 100000" if !(2 <= n and n <= 100000) and DEBUG_PRINT

  data
end

def find_anomalies(data)
  previous = -1
  baseline = -1
  anomalies = []
  bound = 0

  while bound < data.length
    if data[bound] < baseline
      anomalies << bound
    elsif data[bound] < previous
      anomalies << bound - 1
    else
      baseline = previous
    end
    previous = data[bound]
    bound += 1
  end

  anomalies
end

def is_valid(data, position)
  return is_valid_before(data, position) && is_valid_after(data, position)
end

def is_valid_before(data, position)
  return (position <= 0 || data[position - 1] < data[position])
end

def is_valid_after(data, position)
  return (position >= data.length - 1 || data[position + 1] > data[position])
end

def check_swap(data, first, second)
  data[first], data[second] = data[second], data[first]
  if is_valid(data, first) && is_valid(data, second)
    print_yes(:swap, first, second)
  else
    print_no
  end
end

def check_reverse(data, anomalies)
  i, j = 1, anomalies.first
  while i < anomalies.length
    # Non-continuous? Not reversible
    print_no if anomalies[i] - j > i
    i += 1
  end
  first = anomalies.first
  last = anomalies.last + 1

  previous = data[first]
  (first + 1..last).each do |i|
    # Anomaly range has a value larger than previous? Not reversible
    print_no if previous < data[i]
    previous = data[i]
  end

  data[first], data[last] = data[last], data[first]

  if is_valid_before(data, first) && is_valid_after(data, last)
    print_yes :reverse, first, last
  else
    print_no
  end
end

def print_yes(action, first = 0, second = 0)
  puts "yes"
  if action == :swap || action == :reverse
    puts "#{action} #{first + 1} #{second + 1}"
  end
  exit
end

def print_no()
  puts "no"
  exit
end

data = parse_input()
anomalies = find_anomalies(data)

$stderr.print "anomalies #{anomalies.length}: #{anomalies.join ','}" if DEBUG_PRINT

# No anomalies? We're done
print_yes :none if anomalies.length == 0

# One anomaly? Might be able to swap
if anomalies.length == 1
  check_swap(data, anomalies.first, anomalies.first + 1)
end

# Two and non-continuous? Might be able to swap
if anomalies.length == 2
  first = anomalies[0]
  second = anomalies[1]
  if second - first > 1
    check_swap(data, first, second)
  end
end

# Otherwise, try to reverse
check_reverse(data, anomalies)
