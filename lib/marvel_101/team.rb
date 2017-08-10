require_relative 'topic'

class Marvel101::Team < Marvel101::Topic

  attr_accessor :list, :members, :description

  def display
    puts "Description: #{description}" if description
    urls.each do |type, value|
      puts "#{type.to_s.split("_").join(" ").capitalize}: #{value}"
    end
    puts "Core Members:" if members.size > 0
    members.each.with_index(1) {|member, index| puts "    #{index}. #{member.name}"}
  end
end
