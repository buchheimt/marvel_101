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
    puts "\nWelcome to Marvel 101!"
    main_menu
  end

  def main_menu
    display_main
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
    puts "\n" + "-" * 80
    puts "Here are your primary options:"
    STARTING_PAGES.each.with_index(1) {|page, idx| puts "#{idx}. #{page[0]}!"}
    puts "-" * 80
    puts "You can also enter (E)xit to... exit"
    puts "Select a number from the options above and we'll get started!"
  end

  def display_topic(topic)
    break_len = (80 - topic.name.size) / 2
    puts "\n" + "-" * break_len + "#{topic.name}" + "-" * break_len
    topic.display
    puts "-" * (break_len * 2 + topic.name.size)
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

  def error(subject)
    puts "\nSorry, that wasn't a valid option. Let's try again."
    subject == "main" ? main_menu : topic_menu(subject)
  end
end
