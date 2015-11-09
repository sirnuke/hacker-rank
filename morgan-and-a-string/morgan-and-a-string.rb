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

DEBUG_PRINT=true

def find(first, second, position)
  if first.length == 0 && second.length == 0
    return :done, 0
  elsif first.length == 0
    return :second, second.length
  elsif second.length == 0
    return :first, first.length
  elsif position >= first.length && position >= second.length
    return :first, 1 #first.length
  elsif position >= first.length
    if first[position] < second[position - 1]
      return :first, 1 #position + 1
    else
      return :second, 1 #second.length
    end
  elsif position >= second.length
    if second[position] < first[position - 1]
      return :second, 1 #position + 1
    else
      return :first, 1 #first.length
    end
  elsif first[position] < second[position]
    return :first, 1 #position + 1
  elsif first[position] > second[position]
    return :second, 1 #position + 1
  else
    return find(first, second, position + 1)
  end
end

gets.to_i.times do
  first = gets.chomp.chars
  second = gets.chomp.chars
  solution = []
  while true #first.length > 0 || second.length > 0
    action, length = find(first, second, 0)
    case action
    when :done
      $stderr.puts "Done: '#{solution.join ''} f'#{first.join ','}' s'#{second.join ','}'" if DEBUG_PRINT
      break
    when :first
      $stderr.puts "Grabbing #{length} from f'#{first.join ','}' (s'#{second.join ','}')" if DEBUG_PRINT
      solution.concat(first[0, length])
      first = first[length..-1]
      $stderr.puts "Solution is '#{solution.join ''}' f'#{first.join ','}'" if DEBUG_PRINT
    when :second
      $stderr.puts "Grabbing #{length} from s'#{second.join ','}' (f'#{first.join ','}')" if DEBUG_PRINT
      solution.concat(second[0, length])
      second = second[length..-1]
      $stderr.puts "Solution is '#{solution.join ''}' s'#{second.join ','}'" if DEBUG_PRINT
    else
      $stderr.puts "Invalid select return value!" if DEBUG_PRINT
      break
    end
  end
  puts solution.join ''
  #puts first.join ','
  #puts second.join ','
end

