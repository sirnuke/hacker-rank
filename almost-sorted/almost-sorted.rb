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

def parse_input
  n = gets.to_i
  data = gets.split.map {|i| i.to_i }

  $stderr.puts "#{n} != #{data.length}" if n != data.length
  $stderr.puts "2 <= #{n} <= 100000" unless 2 <= n and n <= 100000

  data
end

def find_anomalies(data)
  previous = -1
  baseline = -1
  anomalies = []
  bound = 0

  while bound < data.length
    if data[bound] > previous
      baseline = previous
    else
      anomalies << bound - 1
    end
    previous = data[bound]
    bound += 1
  end

  anomalies
end

data = parse_input()
anomalies = find_anomalies(data)

# No anomalies? We're done
if anomalies.length == 0
  puts "yes"
  exit
end


puts anomalies
