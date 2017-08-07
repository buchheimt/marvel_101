class Marvel101::CLI

  def call
    puts "Welcome to Marvel 101!"
    main_menu
  end

  def main_menu
    display_main
    input = gets.chomp.to_i
    case input
    when 1 then category_menu("Popular Teams")
    when 2 then category_menu("Popular Heroes")
    when 3 then category_menu("Popular Villains")
    when 4 then category_menu("Featured Characters")
    when 5 then category_menu("Women of Marvel")
    when 6 then exit_message
    else
      puts "Yeah... that's not an option. Let's try that again."
      main_menu
    end
  end

  def display_main
    puts "Here are your primary options:"
    puts "1. Popular Teams!"
    puts "2. Popular Heroes!"
    puts "3. Popular Villains!"
    puts "4. Marvel's Currently Featured!"
    puts "5. Women of Marvel!"
    puts "6. Exit Marvel 101"
    puts "Select a number from the options above and we'll get started!"
  end

  def category_menu(category)
    target_category = Marvel101::Category.new("#{category}", "#{category} url")
    display_category(target_category)
    input = gets.chomp
    case input.downcase
    when "main" then main_menu
    when "exit" then exit_message
    else
      if target_category.name == "Popular Teams"
        team_menu(target_category.topics[input.to_i - 1])
      else
        character_menu(target_category.topics[input.to_i - 1])
      end
    end
  end

  def display_category(target_category)
    puts "\n#{target_category.name}? Nice pick!"
    puts "Here is a list of #{target_category.name}! (Sorry if your favorite didn't make the cut)"
    target_category.topics.each.with_index(1) {|topic, index| puts "#{index}. #{topic.name}"}
    puts "Select a number from the options above to learn more!"
    puts "You can also enter 'main' to go back to the main menu or 'exit' to... exit"
  end

  def team_menu(team)
    display_team(team)
    input = gets.chomp
    case input.downcase
    when "main" then main_menu
    when "exit" then exit_message
    else character_menu(team.members[input.to_i - 1])
    end
  end

  def display_team(team)
    puts "You selected the #{team.name}, awesome!"
    puts "Here is some more info about the #{team.name}."
    puts "-" * 15 + "The #{team.name}" + "-" * 15
    puts "Core Members: "
    team.members.each.with_index(1) {|member, index| puts "    #{index}. #{member.name}"}
    puts "Description: #{team.description}"
    puts "Location: #{team.location}"
    puts "Select a number from the options above to learn more!"
    puts "You can also enter 'main' to go back to the main menu or 'exit' to... exit"
  end

  def character_menu(character)
    display_character(character)
    input = gets.chomp
    case input.downcase
    when "main" then main_menu
    else exit_message
    end
  end

  def display_character(character)
    puts "Hi I'm #{character.name}!"
    puts "You can enter 'main' to go back to the main menu or 'exit' to... exit"
  end

  def exit_message
    puts "Oh ok, well have a super day!"
  end

end
