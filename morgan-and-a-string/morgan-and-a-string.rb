#!/usr/bin/env ruby
#
# Morgan and a String HackerRank Challenge
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

gets.to_i.times do
  first = gets.chomp.chars
  second = gets.chomp.chars
  solution = []
  while first.length > 0 || second.length > 0
    if first.length == 0 || second.first < first.first
      solution << second.shift
    else
      solution << first.shift
    end
  end
  puts solution.join ''
  #puts first.join ','
  #puts second.join ','
end

