require_relative 'topic'

class Marvel101::Team < Marvel101::Topic

  attr_accessor :list, :members, :details, :description,
                :url_101, :url_wiki

  DETAILS = [:description, :url, :url_101, :url_wiki]

  def display
    DETAILS.each do |detail|
      puts "#{detail.to_s.split("_").join(" ").capitalize}: #{self.send("#{detail}")}" if self.send("#{detail}")
    end
    puts "Core Members:" if members.size > 0
    members.each.with_index(1) {|member, index| puts "    #{index}. #{member.name}"}
  end
end
