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
      topic_menu(Marvel101::List.find_or_create_by_name(name, url))
    elsif input == "exit" || input == "e"
      exit_message
    else
      error_message("main")
    end
  end

  def display_main
    puts "\nHere are your primary options:"
    STARTING_PAGES.each.with_index(1) {|page, index| puts "#{index}. #{page[0]}!"}
    puts "Exit. Exit Marvel 101"
    puts "Select a number from the options above and we'll get started!"
  end

  def topic_menu(topic)
    topic.get_info unless topic.scraped?
    display_topic(topic)
    input = gets.chomp.downcase
    case input
    when "e", "exit"  then exit_message
    when "m", "main"  then main_menu
    when "l", "list"
      topic.is_a?(Marvel101::List) ? error_message(topic) : topic_menu(topic.list)
    when "t", "team"
      topic.is_a?(Marvel101::Character) && topic.team ? topic_menu(topic.team) : error_message(topic)
    else
      if valid_input?(input, topic) && topic.is_a?(Marvel101::List)
        topic_menu(topic.topics[input.to_i - 1])
      elsif valid_input?(input, topic)
        topic_menu(topic.members[input.to_i - 1])
      else
        error_message(topic)
      end
    end
  end

  def display_topic(topic)
    puts "\nYou selected the #{topic.name}, awesome!"
    puts "Here is some more info about the #{topic.name}."
    puts "-" * 20 + "The #{topic.name}" + "-" * 20
    topic.display
    puts "-" * 20 + "-" * "The #{topic.name}".size + "-" * 20
    puts "Select a number from the options above to learn more!"
    options_message(topic)
  end

  def valid_input?(input, subject)
    if subject.is_a?(Marvel101::List)
      input.to_i.between?(1, subject.topics.size)
    elsif subject.is_a?(Marvel101::Team)
      input.to_i.between?(1, subject.members.size)
    elsif subject.is_a?(Array)
      input.to_i.between?(1, subject.size)
    end
  end

  def exit_message
    puts "\nOh ok, well have a super day!"
  end

  def error_message(subject)
    puts "\nSorry, that wasn't a valid option. Let's try again."
    subject == "main" ? main_menu : topic_menu(subject)
  end

  def options_message(topic)
    puts "You can enter '(M)ain' to go back to the main menu or '(E)xit' to... exit"
    puts "you can also type '(L)ist' to return to the #{topic.list.name} menu" if topic.is_a?(Marvel101::Team) || topic.is_a?(Marvel101::Character)
    puts "you can also type '(T)eam' to return to the #{topic.team.name} menu" if topic.is_a?(Marvel101::Character) && topic.team
  end

end
