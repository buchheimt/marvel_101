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
    when 1 then list_menu("Teams")
    when 2 then list_menu("heroes")
    when 3 then list_menu("villains")
    when 4 then list_menu("featured")
    when 5 then list_menu("women")
    when 6 then puts "Sure thing, have a super day! (haha super... get it?)"
    else
      puts "Yeah... that's not an option. Let's try that again."
      main_menu
    end
  end

  def list_menu(category)
    display_category = Marvel101::Category.new(category, "Teams url")
    display_category.add_topics
    puts "cool you selected #{display_category.name}. Right now this is a stub though and I don't care!"
    puts "Here are Marvel's popular teams! (Sorry if your favorite didn't make the cut)"
    display_category.topics.each.with_index(1) {|team, index| puts "#{index}. #{team.name}"}
    puts "Select a number from the options above to learn more!"
    input = gets.chomp.to_i - 1
    display_team(display_category.topics[input])
  end

  def display_team(team)
    puts "So you definitely selected the #{team.name}, cool."
    puts "Here is some more info about the #{team.name}!"
    puts "-" * 15 + "The #{team.name}" + "-" * 15
    puts "Core Members: "
    team.members.each.with_index(1) {|member, index| puts "    #{index}. #{member}"}
    puts "Description: #{team.description}"
    puts "Location: #{team.location}"
    puts "Select a number from the options above to learn more!"
    input = gets.chomp.to_i - 1
    display_character(team.members[input])
  end

  def display_character(character)
    puts "Hi I'm #{character}!"
  end

end
