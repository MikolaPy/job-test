require 'tempfile'
require './large_sort'

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


def write__temp__file(lines)
  temp__file = Tempfile.new('sorted__chunk')
  temp__file.puts(lines)
  temp__file.close
  temp__file.path
end


lines = [
  '2023-09-03T12:45:00Z,txn12345,user987,500.25',
  '2023-09-03T12:45:00Z,txn12345,user987,50.25',
  '2023-09-03T12:45:00Z,txn12345,user987,550.25',
]

large_file = write__temp__file(lines)

# sort__large__file(input__file, output__file)
# output__file = 'sorted__large__file.txt'

def split
  sorted_chunks = []
  chunk_entries = []

  enumerable.each do |entry|
    chunk_entries << entry

    if chunk_entries.size == chunk_size
      sorted_chunks << write_sorted_chunk(chunk_entries)
      chunk_entries.clear
    end
  end

  sorted_chunks << write_sorted_chunk(chunk_entries) unless chunk_entries.empty?

  sorted_chunks
end



