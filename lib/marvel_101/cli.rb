class Marvel101::CLI

  SOURCE = "http://marvel.com/characters/"

  STARTING_PAGES = [
    ["Popular Teams", "list/997/titanic_teams"],
    ["Popular Heroes", "list/994/top_marvel_heroes"],
    ["Popular Villains", "list/995/bring_on_the_bad_guys"],
    ["Featured Characters", "browse"],
    ["The Women of Marvel", "list/996/women_of_marvel"]
  ]

  def call
    puts "Welcome to Marvel 101!"
    main_menu
  end

  def main_menu
    display_main
    input = gets.chomp.downcase
    output = valid_input?(input.to_i, STARTING_PAGES)
    if output
      name, url = output
      topic_menu(Marvel101::List.find_or_create_by_name(name, SOURCE + url))
    elsif input == "exit" || input == "e"
      exit_message
    else
      error_message("main")
    end
  end

  def display_main
    puts "\nHere are your primary options:"
    STARTING_PAGES.each.with_index(1) {|page, idx| puts "#{idx}. #{page[0]}!"}
    puts "You can also enter (E)xit to... exit"
    puts "Select a number from the options above and we'll get started!"
  end

  def topic_menu(topic)
    topic.get_info unless topic.scraped
    display_topic(topic)
    input = gets.chomp.downcase
    case input
    when "101", "wiki"
      link = "url_#{input}".to_sym
      open_link(topic.urls["url_#{input}".to_sym]) if topic.urls.include?(link)
      topic_menu(topic)
    when "source"
      open_link(topic.urls[:url])
      topic_menu(topic)
    when "e", "exit" then exit_message
    when "m", "main" then main_menu
    when "l", "list"
      topic.list? ? error_message(topic) : topic_menu(topic.list)
    when "t", "team"
      topic.char? && topic.team ? topic_menu(topic.team) : error_message(topic)
    else
      output = valid_input?(input.to_i, topic)
      output ? topic_menu(output) : error_message(topic)
    end
  end

  def display_topic(topic)
    break_len = 25
    puts "\nYou selected #{topic.name}, awesome!"
    puts "Here is some more info about #{topic.name}."
    puts "-" * break_len + "#{topic.name}" + "-" * break_len
    topic.display
    puts "-" * break_len + "-" * "#{topic.name}".size + "-" * break_len
    options_message(topic)
  end

  def open_link(url)
    Launchy.open(url)
  end

  def exit_message
    puts "\nOh ok, well have a super day!"
  end

  def error_message(subject)
    puts "\nSorry, that wasn't a valid option. Let's try again."
    subject == "main" ? main_menu : topic_menu(subject)
  end

  def options_message(topic)
    puts "Enter an option number for more info!" if topic.takes_input?
    puts "You can enter (M)ain to go back to the main menu or (E)xit to... exit"
    puts "Type (L)ist to return to #{topic.list.name} menu" if !topic.list?
    puts "Type (T)eam to return to #{topic.team.name} menu" if topic.has_team?
  end

  def valid_input?(input, topic)
    if topic.is_a?(Array)
      topic[input - 1] if input.between?(1, topic.size)
    elsif topic.list?
      topic.items[input - 1] if input.between?(1, topic.items.size)
    elsif topic.team?
      topic.members[input - 1] if input.between?(1, topic.members.size)
    end
  end
end
