require 'tempfile'
require './task1/min_heap_sorter.rb'
require './task1/transaction.rb'
require './task1/string_merge_sorter.rb'


def sort_file(input_file, output_file)
  file_enum = File.readlines(input_file).each

  File.open(output_file, 'w') do |output|
    StringMergeSorter.new(file_enum, 10).each { |line| p line; output.puts line }
  end
end

sort_file('log.txt', 'sorted_log.txt')
