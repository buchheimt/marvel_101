class Marvel101::CLI

  def call
    puts "Welcome to Marvel 101!"
    main_menu
  end

  def main_menu
    puts "Here are your primary options:"
    puts "1. Popular Teams!"
    puts "2. Popular Heroes!"
    puts "3. Popular Villains!"
    puts "4. Marvel's Currently Featured!"
    puts "5. Women of Marvel!"
    puts "6. Exit Marvel 101"
    puts "Select a number from the options above and we'll get started!"
    input = gets.chomp.to_i
    case input
    when 1 then list_menu("Popular Teams")
    when 2 then list_menu("Popular Heroes")
    when 3 then list_menu("Popular Villains")
    when 4 then list_menu("Featured Characters")
    when 5 then list_menu("Women of Marvel")
    when 6 then puts "Sure thing, have a super day! (haha super... get it?)"
    else
      puts "Yeah... that's not an option. Let's try that again."
      main_menu
    end
  end

  def list_menu(category)
    display_category = Marvel101::Category.new("#{category}", "#{category} url")
    puts "#{display_category.name}? Nice pick!"
    puts "Here is a list of #{category}! (Sorry if your favorite didn't make the cut)"
    display_category.topics.each.with_index(1) {|topic, index| puts "#{index}. #{topic.name}"}
    puts "Select a number from the options above to learn more!"
    input = gets.chomp.to_i - 1
    if category == "Popular Teams"
      display_team(display_category.topics[input])
    else
      display_character(display_category.topics[input])
    end
  end

  def display_team(team)
    puts "So you definitely selected the #{team.name}, cool."
    puts "Here is some more info about the #{team.name}!"
    puts "-" * 15 + "The #{team.name}" + "-" * 15
    puts "Core Members: "
    team.members.each.with_index(1) {|member, index| puts "    #{index}. #{member.name}"}
    puts "Description: #{team.description}"
    puts "Location: #{team.location}"
    puts "Select a number from the options above to learn more!"
    input = gets.chomp.to_i - 1
    display_character(team.members[input])
  end

  def display_character(character)
    puts "Hi I'm #{character.name}!"
  end

end
