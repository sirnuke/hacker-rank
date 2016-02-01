#!/usr/bin/env ruby

DEBUG=true

gets.to_i.times do
  n = gets.to_i
  array = gets.split.map {|i| i.to_i }
  result = 0
  offset = 0
  bump = n

  $stderr.puts "#{n} != #{array.length}" if n != array.length and DEBUG

  (0..n - 1).each do |i|
    $stderr.puts "round #{i}: offset #{offset} bump #{bump}" if DEBUG
    amount = n + offset
    result = result ^ array[i] if amount % 2 == 1
    if DEBUG
      if amount % 2 == 1
        $stderr.puts "xoring #{i} (#{amount}): #{array[i]}"
      else
        $stderr.puts "ignore #{i} (#{amount}): #{array[i]}"
      end
    end
    bump -= 2
    offset += bump
  end
  puts result
  $stderr.puts "result = #{result}" if DEBUG
end

