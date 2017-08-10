require_relative 'topic'

class Marvel101::Team < Marvel101::Topic

  attr_accessor :list, :members, :description, :details
  
  def display
    puts "DESCRIPTION: #{description}" if description
    puts "CORE MEMBERS:" if members.size > 0
    members.each.with_index(1) {|member, index| puts "    #{index}. #{member.name}"}
    puts "Marvel Wiki page available! Type 'wiki' to open in browser" if urls.include?(:url_wiki)
    puts "Marvel Wiki page available! Type '101' to open in browser" if urls.include?(:url_101)
  end
end
