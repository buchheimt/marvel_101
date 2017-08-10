require_relative 'topic'

class Marvel101::Character < Marvel101::Topic

  attr_accessor :list, :team, :details, :detail_order, :description

  DETAIL_ORDER = [:real_name, :height, :weight, :powers, :abilities,
                  :group_affiliations, :first_appearance, :origin]

  def display
    # maybe try grouping name/height/weight/abilities then long stuff then origins/urls/etc.
    puts "Description: #{description}" if description
    DETAIL_ORDER.each do |type|
      puts "" if details.include?(type) && details[type].size >= 80
      puts "#{type.to_s.split("_").join(" ").capitalize}: #{details[type]}" if details.include?(type)
      puts "" if details.include?(type) && details[type].size >= 80
    end
    puts "" if urls.include?(:url_wiki) || urls.include?(:url_101)
    puts "Marvel Wiki page available! Type 'wiki' to open in browser" if urls.include?(:url_wiki)
    puts "Marvel 101 video available! Type '101' to open in browser" if urls.include?(:url_101)
    if empty?
      puts "Sorry, Marvel doesn't seem to care about #{name}."
      puts "Type 'show me' to open the page in browser, but don't get your hopes up."
    end
  end

  def empty?
    !description || details.size <= 0 || urls.size <= 1
  end
end
