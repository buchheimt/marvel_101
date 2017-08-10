require_relative 'topic'

class Marvel101::Character < Marvel101::Topic

  attr_accessor :list, :team, :details, :description, :real_name,
                :height, :weight, :powers, :abilities, :group_affiliations, :first_appearance,
                :origin, :url_101, :url_wiki

  DETAILS = [:real_name, :description, :height, :weight, :powers, :abilities,
              :group_affiliations, :first_appearance, :origin, :url, :url_101, :url_wiki]

  def display
    # maybe try grouping name/height/weight/abilities then long stuff then origins/urls/etc.
    DETAILS.each do |detail|
      puts "" if self.send("#{detail}") && self.send("#{detail}").size >= 80
      puts "#{detail.to_s.split("_").join(" ").capitalize}: #{self.send("#{detail}")}" if self.send("#{detail}")
      puts "" if self.send("#{detail}") && self.send("#{detail}").size >= 80
    end
  end
end
