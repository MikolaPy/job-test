class MinHeapSorter
  include Enumerable

  attr_reader :array, :sort_by, :heap_end

  def initialize(&sort_by)
    @sort_by = sort_by || Proc.new { |item| item }
    @array = []
    @heap_end = -1
  end

  def <<(item)
    @heap_end += 1
    array[heap_end] = item
    sift_up(heap_end)
  end

  def pop
    item = array.first
    array[0] = array[heap_end]
    heapify(0)
    shrink_heap unless item.nil?
    item
  end

  def size
    heap_end + 1 
  end

  def empty?
    size == 0
  end

  def each
    while (min = pop)
      yield min 
    end 
  end

  private

  def shrink_heap
    array[heap_end] = nil
    @heap_end -= 1
  end

  def compare(i, j)
    (sort_by.call(array[i]) <=> sort_by.call(array[j])) == -1
  end

  def swap(i, j)
    array[i], array[j] = array[j], array[i]
  end

  def parent(i)
    (i - 1) / 2
  end

  def left(i)
    (2 * i) + 1
  end

  def right(i)
    (2 * i) + 2
  end

  def heapify(i)
    l = left(i)
    top = (l <= heap_end) && compare(l, i) ? l : i

    r = right(i)
    top = (r <= heap_end) && compare(r, top) ? r : top

    if top != i
      swap(i, top)
      heapify(top)
    end
  end

  def sift_up(i)
    if i > 0
      p = parent(i)

      if p && compare(i, p)
        swap(i, p)
        sift_up(p)
      end
    end
  end
end
