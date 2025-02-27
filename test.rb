

# def write__temp__file(lines)
#   temp__file = Tempfile.new('sorted__chunk')
#   temp__file.puts(lines)
#   temp__file.close
#   temp__file.path
# end
#
# log = write__temp__file(lines)

# sort__large__file(input__file, output__file)
# output__file = 'sorted__large__file.txt'
#
# def merge(sorted_chunk_ios)
#   pq = []
#   chunk_enumerators = sorted_chunk_ios.map(&:each)

#   chunk_enumerators.each_with_index do |chunk, index|
#     entry = chunk.next
#     pq.push(ChunkEntry.new(index, entry))
#   end

#   entry_sort_by = Proc.new { |entry| sort_by.call(entry.data) }
#   pq = FixedSizeMinHeap.new(pq, &entry_sort_by)

#   Enumerator.new do |yielder|
#     while (item = pq.pop)
#       yielder.yield(item.data)

#       begin
#         entry = chunk_enumerators[item.chunk_number].next
#         pq.push(ChunkEntry.new(item.chunk_number, entry))
#       rescue StopIteration
#         sorted_chunk_ios[item.chunk_number].close
#       end
#     end
#   end
# end
#
# def sort__large__file(input__file, output__file, chunk__size = 1000)
#   temp__files = []
#
#   **1. Чтение файла построчно и разбивка на отсортированные части**
#   File.open(input__file, 'r') do |file|
#     lines = []
#
#     file.each__line do |line|
#       lines << line.strip  **Убираем лишние пробелы и переводы строки**
#
#       if lines.size >= chunk__size
#         **Сортируем текущую часть и записываем во временный файл**
#         sorted__lines = lines.sort
#         temp__files << write__temp__file(sorted__lines)
#         lines.clear  **Очищаем массив для следующей части**
#       end
#     end
#
#     **Обработка оставшихся строк**
#     unless lines.empty?
#       sorted__lines = lines.sort
#       temp__files << write__temp__file(sorted__lines)
#     end
#   end
#
#   **2. Слияние отсортированных временных файлов**
#   merge__sorted__files(temp__files, output__file)
# end
#
# def write__temp__file(lines)
#   temp__file = Tempfile.new('sorted__chunk')
#   temp__file.puts(lines)
#   temp__file.close
#   temp__file.path
# end
#
# def merge__sorted__files(temp__files, output__file)
#   sorted__lines = []
#   file__handles = temp__files.map { |file| File.open(file, 'r') }
#
#   **Инициализация первой строки из каждого временного файла**
#   file__handles.each__with__index do |handle, index|
#     line = handle.gets
#     sorted__lines << [line, index] if line
#   end
#
#   **Сортировка и запись в выходной файл**
#   File.open(output__file, 'w') do |output|
#     until sorted__lines.empty?
#       **Сортируем и находим минимальную строку**
#       sorted__lines.sort__by! { |line, __| line }
#       min__line, min__index = sorted__lines.shift
#
#       output.puts(min__line.strip)  **Записываем минимальную строку в выходной файл**
#
#       **Читаем следующую строку из временного файла**
#       next__line = file__handles[min__index].gets
#       if next__line
#         sorted__lines << [next__line, min__index]
#       end
#     end
#   end
#
#   **Закрытие временных файлов**
#   file__handles.each(&:close)
#   temp__files.each { |file| File.delete(file) }  **Удаляем временные файлы**
# end


# input__file = 'large__file.txt'
#
    transactions = entries.map { |line| Transaction.new line } 
    sort_transactions(transactions)

  def write_sorted_chunk(entries)
    transactions = entries.map { |line| Transaction.new line } 
    sort_transactions(transactions)

    # file = Tempfile.open('chunk')
    # file.binmode

    # chunk_io = chunk_input_output_class.new(file)
    # entries.sort_by(&sort_by).each { |entry| chunk_io.write_entry(entry) }

    # chunk_io.rewind
    # chunk_io
  end


def write__temp__file(lines)
  temp__file = Tempfile.new('sorted__chunk')
  temp__file.puts(lines)
  temp__file.close
  temp__file.path
end

  def merge(chunks)
    # pq = []
    # chunk_enumerators = chunks.map(&:each)

    # chunk_enumerators.each_with_index do |chunk, index|
    #   entry = chunk.next
    #   pq.push(ChunkEntry.new(index, entry))
    # end

    # entry_sort_by = Proc.new { |entry| sort_by.call(entry.data) }
    # pq = FixedSizeMinHeap.new(pq, &entry_sort_by)

    # Enumerator.new do |yielder|
    #   while (item = pq.pop)
    #     yielder.yield(item.data)

    #     begin
    #       entry = chunk_enumerators[item.chunk_number].next
    #       pq.push(ChunkEntry.new(item.chunk_number, entry))
    #     rescue StopIteration
    #       chunks[item.chunk_number].close
    #     end
    #   end
    # end
  end
