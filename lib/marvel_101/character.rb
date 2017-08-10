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
    urls.each do |type, value|
      puts "#{type.to_s.split("_").join(" ").capitalize}: #{value}"
    end
  end
end
