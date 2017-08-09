class Marvel101::CLI

  STARTING_PAGES = [
    ["Popular Teams", "http://marvel.com/characters/list/997/titanic_teams"],
    ["Popular Heroes", "http://marvel.com/characters/list/994/top_marvel_heroes"],
    ["Popular Villains", "http://marvel.com/characters/list/995/bring_on_the_bad_guys"],
    ["Featured Characters", "http://marvel.com/characters/browse"],
    ["The Women of Marvel", "http://marvel.com/characters/list/996/women_of_marvel"]
  ]

  def call
    puts "Welcome to Marvel 101!"
    main_menu
  end

  def main_menu
    display_main
    input = gets.chomp.downcase
    if valid_input?(input, STARTING_PAGES)
      name, url = STARTING_PAGES[input.to_i - 1]
      list_menu(Marvel101::List.find_or_create_by_name(name, url))
    elsif input == "exit"
      exit_message
    else
      error_message
      main_menu
    end
  end

  def display_main
    puts "\nHere are your primary options:"
    STARTING_PAGES.each.with_index(1) {|page, index| puts "#{index}. #{page[0]}!"}
    puts "Exit. Exit Marvel 101"
    puts "Select a number from the options above and we'll get started!"
  end

  def list_menu(list)
    display_list(list)
    input = gets.chomp.downcase
    case input
    when "main" then main_menu
    when "exit" then exit_message
    else
      if valid_input?(input, list.topics)
        topic = list.topics[input.to_i - 1]
        topic.is_a?(Marvel101::Team) ? team_menu(topic) : character_menu(topic)
      else
        error_message
        list_menu(clist)
      end
    end
  end

  def display_list(list)
    puts "\n#{list.name}? Nice pick!"
    puts "Here is a list of #{list.name}! (Sorry if your favorite didn't make the cut)"
    puts "-" * 15 + "The #{list.name}" + "-" * 15
    list.topics.each.with_index(1) {|topic, index| puts "#{index}. #{topic.name}"}
    puts "-" * 15 + "-" * "The #{list.name}".size + "-" * 15
    puts "Select a topic number from the options above to learn more!"
    options_message(list)
  end

  def team_menu(team)
    team.get_info unless team.scraped?
    display_team(team)
    input = gets.chomp.downcase
    case input
    when "main" then main_menu
    when "exit" then exit_message
    when "list" then list_menu(team.list)
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
    when "list" then list_menu(character.list)
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
    puts "you can also type 'list' to return to the #{topic.list.name} menu" if topic.is_a?(Marvel101::Team) || topic.is_a?(Marvel101::Character)
    puts "you can also type 'team' to return to the #{topic.team.name} menu" if topic.is_a?(Marvel101::Character) && topic.team
  end

end
