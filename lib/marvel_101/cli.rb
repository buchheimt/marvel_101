class Marvel101::CLI

  SOURCE = "http://marvel.com/characters/"

  STARTING_PAGES = [
    ["Popular Teams", "list/997/titanic_teams"],
    ["Popular Heroes", "list/994/top_marvel_heroes"],
    ["Popular Villains", "list/995/bring_on_the_bad_guys"],
    ["Featured Characters", "browse"],
    ["The Women of Marvel", "list/996/women_of_marvel"]
  ]

  LINE_LEN = 80

  def call
    puts "\nWelcome to Marvel 101!"
    main_menu
  end

  def main_menu
    display_main
    print ">> "
    input = gets.chomp.downcase

    if input.to_i.between?(1, STARTING_PAGES.size)
      name, url = STARTING_PAGES[input.to_i - 1]
      topic_menu(Marvel101::List.find_or_create_by_name(name, SOURCE + url))
    elsif input == "exit" || input == "e"
      exit_message
    else
      error("main")
    end
  end

  def topic_menu(topic)
    topic.get_info unless topic.scraped
    display_topic(topic)
    print ">> "
    input = gets.chomp.downcase

    case input
    when "101","wiki" then open_link("url_#{input}".to_sym, topic)
    when "source" then open_link(:url, topic)
    when "e","exit" then exit_message
    when "m","main" then main_menu
    when "l","list" then topic.list? ? error(topic) : topic_menu(topic.list)
    when "t","team" then topic.has_team? ? topic_menu(topic.team) : error(topic)
    else
      output = topic.valid_input?(input.to_i)
      output ? topic_menu(output) : error(topic)
    end
  end

  def display_main
    puts "\n" + "-" * LINE_LEN
    puts "Here are your primary options:"
    STARTING_PAGES.each.with_index(1) {|page, idx| puts "#{idx}. #{page[0]}!"}
    puts "-" * LINE_LEN
    puts "You can also enter (E)xit to... exit"
    puts "Select a number from the options above and we'll get started!"
  end

  def display_topic(topic)
    break_len = (LINE_LEN - topic.name.size) / 2.0
    puts "\n" + "-" * break_len.floor + "#{topic.name}" + "-" * break_len.ceil
    topic.display
    puts "-" * LINE_LEN
    options_message(topic)
  end

  def open_link(url, topic)
    Launchy.open(topic.urls[url]) if topic.urls.include?(url)
    topic_menu(topic)
  end

  def exit_message
    puts "\nOh ok, well have a super day!"
  end

  def options_message(topic)
    puts "Enter an option number for more info!" if topic.takes_input?
    puts "You can enter (M)ain to go back to the main menu or (E)xit to... exit"
    puts "Type (L)ist to return to #{topic.list.name} menu" if !topic.list?
    puts "Type (T)eam to return to #{topic.team.name} menu" if topic.has_team?
  end

  def error(topic)
    puts "\nSorry, that wasn't a valid option. Let's try again."
    topic == "main" ? main_menu : topic_menu(topic)
  end
end
