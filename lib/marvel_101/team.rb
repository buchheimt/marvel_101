require_relative 'topic'

class Marvel101::Team < Marvel101::Topic

  attr_accessor :list, :members,

  def display
    display_description
    display_members
    display_links
  end

  def display_members
    puts "CORE MEMBERS:" if members.size > 0
    members.each.with_index(1) {|member, index| puts "    #{index}. #{member.name}"}
  end
end
