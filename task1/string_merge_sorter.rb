class StringMergeSorter
  attr_reader :large_enum, :chunk_size, :files
  include Enumerable

  def initialize(large_enum, chunk_size)
    @large_enum = large_enum
    @chunk_size = chunk_size
    @files = []
  end

  def each
    split_by_files

    files_enumerators = files.map { |file| File.readlines(file).each }

    sorter = new_chunk_sorter { |item| item[0] }

    files_enumerators.each_with_index do |chunk, index|
      line = chunk.next
      object = deserialize line
      sorter << [object, index]
    end

    until sorter.empty?
      object, index = sorter.pop

      yield serialize object

      begin
        line = files_enumerators[index].next
        object = deserialize line
        sorter << [object, index]
      rescue StopIteration
      end
    end
  end

  def split_by_files
    sorter = new_chunk_sorter

    large_enum.each do |entry|
      transaction = Transaction.new entry
      sorter << transaction

      if sorter.size == chunk_size
        files << write(sorter)
        sorter = new_chunk_sorter
      end
    end

    files << write(sorter) unless sorter.empty?
  end

  def new_chunk_sorter
    if block_given?
      MinHeapSorter.new { |i| yield i }
    else
      MinHeapSorter.new 
    end
  end

  def serialize(object)
    object.to_str
  end

  def deserialize(line)
    Transaction.new line 
  end

  def write(sorted_chunk)
    file = Tempfile.new('chunk')
    sorted_chunk.each { |transaction| file.puts(transaction.to_str) }
    file.close
    file.path
  end
end
