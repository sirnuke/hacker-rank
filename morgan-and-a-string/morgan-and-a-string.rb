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

def completed?(data, position)
  (position >= data.length)
end

def find(first, second, position)
  # Quick out
  if first.length == 0 && second.length == 0
    return :done, 0
  elsif first.length == 0
    return :second, second.length
  elsif second.length == 0
    return :first, first.length
  end

  previous = nil
  length = 0
  block = true

  while true
    first_completed = completed?(first, position)
    second_completed = completed?(second, position)

    $stderr.puts "Position #{position} first completed? #{first_completed} second complete? #{second_completed}" if DEBUG_PRINT

    # Identical? pick'em
    if first_completed && second_completed
      return :first, length
    # At the end of one stacks
    elsif first_completed
      if first.last < second[position]
        return :first, length
      elsif first.last > second[position]
        return :second, length
      end
    elsif second_completed
      if second.last < first[position]
        return :second, length
      elsif second.last > first[position]
        return :first, length
      end
    # Both have items remaining
    else
      if first[position] < second[position]
        return :first, length + 1
      elsif first[position] > second[position]
        return :second, length + 1
      end
      if block && (previous.nil? || first[position] <= previous)
        previous = first[position]
        length += 1
        $stderr.puts "Previous is now #{previous}, block length is #{length}, position is #{position}" if DEBUG_PRINT
      else
        block = false
      end
    end
    position += 1
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
end

