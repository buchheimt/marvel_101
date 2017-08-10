require_relative 'topic'

class Marvel101::Character < Marvel101::Topic

  attr_accessor :list, :team, :details

  DETAIL_ORDER = [:real_name, :height, :weight, :abilities, :powers,
                  :group_affiliations, :first_appearance, :origin]

  def display
    display_description
    display_details
    display_links
    display_empty_message if empty?
  end

  def display_details
    DETAIL_ORDER.each do |type|
      puts "#{type.to_s.split("_").join(" ").upcase}: #{details[type]}" if details.include?(type)
      puts "" if details.include?(type) && details[type].size >= 80
    end
  end

  def display_empty_message
    puts "Sorry, Marvel doesn't seem to care about #{name}"
    puts "Type 'show me' to open the page in browser, but don't get your hopes up"
  end

  def empty?
    !description && details.size <= 0 && urls.size <= 1
  end
end
