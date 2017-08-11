require_relative 'topic'

class Marvel101::Team < Marvel101::Topic

  attr_accessor :list, :members

  def display
    display_description
    display_members
    display_links
  end

  def display_members
    puts "CORE MEMBERS:" unless members.empty?
    members.each.with_index(1) {|member, idx| puts "    #{idx}. #{member.name}"}
  end

  def valid_input?(input)
    members[input - 1] if input.between?(1, members.size)
  end
end
