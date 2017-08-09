class Marvel101::CLI

  def call
    puts "Welcome to Marvel 101!"
    main_menu
  end

  def main_menu
    display_main
    input = gets.chomp.downcase
    case input
    when "1" then category_menu(Marvel101::Category.find_or_create_by_name("Popular Teams", "http://marvel.com/characters/list/997/titanic_teams"))
    when "2" then category_menu(Marvel101::Category.find_or_create_by_name("Popular Heroes", "http://marvel.com/characters/list/994/top_marvel_heroes"))
    when "3" then category_menu(Marvel101::Category.find_or_create_by_name("Popular Villains", "http://marvel.com/characters/list/995/bring_on_the_bad_guys"))
    when "4" then category_menu(Marvel101::Category.find_or_create_by_name("Featured Characters", "http://marvel.com/characters/browse"))
    when "5" then category_menu(Marvel101::Category.find_or_create_by_name("The Women of Marvel", "http://marvel.com/characters/list/996/women_of_marvel"))
    when "exit" then exit_message
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
    puts "5. The Women of Marvel!"
    puts "Exit. Exit Marvel 101"
    puts "Select a number from the options above and we'll get started!"
  end

  def category_menu(category)
    display_category(category)
    input = gets.chomp
    case input.downcase
    when "main" then main_menu
    when "exit" then exit_message
    else
      if valid_input?(input, category.topics)
        if category.name == "Popular Teams"
          team_menu(category.topics[input.to_i - 1])
        else
          character_menu(category.topics[input.to_i - 1])
        end
      else
        error_message
        category_menu(category, "url")
      end
    end
  end

  def display_category(category)
    puts "\n#{category.name}? Nice pick!"
    puts "Here is a list of #{category.name}! (Sorry if your favorite didn't make the cut)"
    puts "-" * 15 + "The #{category.name}" + "-" * 15
    category.topics.each.with_index(1) {|topic, index| puts "#{index}. #{topic.name}"}
    puts "-" * 15 + "-" * "The #{category.name}".size + "-" * 15
    puts "Select a topic number from the options above to learn more!"
    options_message(category)
  end

  def team_menu(team)
    team.get_info unless team.scraped?
    display_team(team)
    input = gets.chomp
    case input.downcase
    when "main" then main_menu
    when "exit" then exit_message
    when "category" then category_menu(team.category.name, "url")
    else
      if valid_input?(input, team.members)
          character_menu(team.members[input.to_i - 1])
      else
        error_message
        team_menu(team)
      end
    end
  end

  def display_team(team)
    puts "\nYou selected the #{team.name}, awesome!"
    puts "Here is some more info about the #{team.name}."
    puts "-" * 15 + "The #{team.name}" + "-" * 15
    team.details.each do |detail|
      puts "#{detail.to_s.split("_").join(" ").capitalize}: #{team.send("#{detail}")}" if team.send("#{detail}")
    end
    if team.members
      puts "Core Members:"
      team.members.each.with_index(1) {|member, index| puts "    #{index}. #{member.name}"}
    end
    puts "-" * 15 + "-" * "The #{team.name}".size + "-" * 15

    puts "Select a character number from the options above to learn more!"
    options_message(team)
  end

  def character_menu(character)
    character.get_info unless character.scraped?
    display_character(character)
    input = gets.chomp
    case input.downcase
    when "main" then main_menu
    when "category" then category_menu(character.category.name, "url")
    when "exit" then exit_message
    else
      if input.downcase == "team"
        team_menu(character.team)
      else
        error_message
        character_menu(character)
      end
    end
  end

  def display_character(character)
    # maybe try grouping name/height/weight/abilities then long stuff then origins/urls/etc.
    puts "\n#{character.name} it is!"
    puts "-" * 15 + "#{character.name}" + "-" * 15
    character.details.each do |detail|
      puts "" if character.send("#{detail}") && character.send("#{detail}").size >= 80
      puts "#{detail.to_s.split("_").join(" ").capitalize}: #{character.send("#{detail}")}" if character.send("#{detail}")
      puts "" if character.send("#{detail}") && character.send("#{detail}").size >= 80
    end
    puts "-" * 15 + "-" * "#{character.name}".size + "-" * 15

    options_message(character)
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

  def options_message(topic)
    puts "You can enter 'main' to go back to the main menu or 'exit' to... exit"
    puts "you can also type 'category' to return to the #{topic.category.name} menu" if topic.is_a?(Marvel101::Team) || topic.is_a?(Marvel101::Character)
    puts "you can also type 'team' to return to the #{topic.team.name} menu" if topic.is_a?(Marvel101::Character) && topic.team
  end

end
