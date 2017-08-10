require_relative 'topic'

class Marvel101::List < Marvel101::Topic

  attr_accessor :items

  def display
    items.each.with_index(1) {|item, index| puts "#{index}. #{item.name}"}
  end

end
