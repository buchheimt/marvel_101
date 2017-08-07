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
      error_message
      main_menu
    end
  end

  def display_main
    puts "\nHere are your primary options:"
    puts "1. Popular Teams!"
    puts "2. Popular Heroes!"
    puts "3. Popular Villains!"
    puts "4. Marvel's Currently Featured!"
    puts "5. Women of Marvel!"
    puts "6. Exit Marvel 101"
    puts "Select a number from the options above and we'll get started!"
  end

  def category_menu(category)
    target_category = Marvel101::Category.find_or_create_by_name("#{category}", "#{category} url")
    display_category(target_category)
    input = gets.chomp
    case input.downcase
    when "main" then main_menu
    when "exit" then exit_message
    else
      if valid_input?(input, target_category.topics)
        if target_category.name == "Popular Teams"
          team_menu(target_category.topics[input.to_i - 1], target_category)
        else
          character_menu(target_category.topics[input.to_i - 1], target_category)
        end
      else
        error_message
        category_menu(category)
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

  def team_menu(team, category)
    team.get_info unless team.scraped?
    display_team(team, category)
    input = gets.chomp
    case input.downcase
    when "main" then main_menu
    when "exit" then exit_message
    when "category" then category_menu(category.name)
    else
      if valid_input?(input, team.members)
          character_menu(team.members[input.to_i - 1], category, team)
      else
        error_message
        team_menu(team, category)
      end
    end
  end

  def display_team(team, category)
    puts "\nYou selected the #{team.name}, awesome!"
    puts "Here is some more info about the #{team.name}."
    puts "-" * 15 + "The #{team.name}" + "-" * 15
    puts "Core Members: "
    team.members.each.with_index(1) {|member, index| puts "    #{index}. #{member.name}"} if team.members
    puts "Description: #{team.description}" if team.description
    puts "Location: #{team.location}" if team.location
    puts "Select a number from the options above to learn more!"
    puts "You can also enter 'main' to go back to the main menu or 'exit' to... exit"
    puts "you can also type 'category' to return to the list of #{category.name}."
  end

  def character_menu(character, category, team = nil)
    character.get_info unless character.scraped?
    display_character(character, category, team)
    input = gets.chomp
    case input.downcase
    when "main" then main_menu
    when "category" then category_menu(category.name)
    when "exit" then exit_message
    else
      if input.downcase == "team"
        team_menu(team, category)
      else
        error_message
        character_menu(character, category, team)
      end
    end
  end

  def display_character(character, category, team)
    puts "\nHi I'm #{character.name}!"
    puts "description: #{character.description}" if character.description
    puts "powers: #{character.powers}" if character.powers
    puts "You can enter 'main' to go back to the main menu or 'exit' to... exit"
    puts "you can also type 'category' to return to the list of #{category.name}."
    puts "you can also type 'team' to return to the list of #{team.name}." if team
  end

  def valid_input?(input, options)
    input.to_i.between?(1,options.size)
  end

  def exit_message
    puts "\nOh ok, well have a super day!"
  end

  def error_message
    puts "\nSorry, that wasn't a valid option. Let's try again."
  end

end
