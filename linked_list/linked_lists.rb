class Node
  attr_accessor :value, :next_node
  def initialize(value=nil,next_node=nil)
    @value = value
    @next_node = next_node
  end

end

class LinkedList
  attr_accessor :head, :tail
  def initialize()
    @head = nil
    @tail = nil
  end

  def append(value)
    if(head == nil)
      prepend(value)
    else
      a = @head
      while a.next_node != nil
        a = a.next_node
      end
      a.next_node = Node.new(value)
    end
  end

  def prepend(value)
    @head = Node.new(value,@head)
  end

  def tail
    a = @head
    while a != nil
      tail = a.value
      a = a.next_node
    end
    return tail
    end

  def size()
    count = 0
    a = @head
    while a != nil
     a = a.next_node
     count += 1
    end
    return count
  end

  def at(index)
    a = @head
    count = 0
    while count != index
      count += 1
     a = a.next_node
    end
    return a.value
  end

  def pop
    current = @head
    while current.next_node != nil
      previous = current
      current = current.next_node
    end
    previous.next_node = current.next_node
  end

  def contains?(value)
    a = @head
    while a.value != value
      a = a.next_node
      return false if a == nil
    end
    return true
  end

  def find(value)
    a = @head
    count = 0
    while a.value != value
      count += 1
      a = a.next_node
      return nil if a == nil
    end
    return count
  end

  def insert_at(value, index)
    current = @head
    count = 0
    if size == 1 or index == 0
      prepend(value)
      return
    end
    while count != index
      previous = current
      current = current.next_node
      count += 1
    end
    previous.next_node = Node.new(value, current)
  end

  def remove_at(index)
    current = @head
    count = 0
    if index == 0
      self.head = current.next_node
      return
    end
    while count != index
      previous = current
      current = current.next_node
      count += 1
    end
    previous.next_node = current.next_node
  end

  def to_s
    a = @head
    str = ''
    while a != nil
      str += "( #{a.value} ) -> "
      a = a.next_node
    end
    str + 'nil'
  end
end
