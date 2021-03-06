require_relative 'topic'

class Marvel101::List < Marvel101::Topic

  attr_accessor :items

  def display
    items.each.with_index(1) {|item, idx| puts "#{idx}. #{item.name}"}
  end

  def valid_input?(input)
    items[input - 1] if input.between?(1, items.size)
  end
end
