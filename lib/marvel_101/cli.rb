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
    when 1 then list_menu("teams")
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

  def list_menu(topic)
    teams = []
    teams << Marvel101::Team.new("Avengers")
    teams << Marvel101::Team.new("X-Men")
    teams << Marvel101::Team.new("Guardians of the Galaxy")
    teams << Marvel101::Team.new("Fantastic Four")
    teams << Marvel101::Team.new("Defenders")
    puts "cool you selected #{topic}. Right now this is a stub though and I don't care!"
    puts "Here are Marvel's popular teams! (Sorry if your favorite didn't make the cut)"
    teams.each.with_index(1) {|team, index| puts "#{index}. #{team.name}"}
    puts "Select a number from the options above to learn more!"
    input = gets.chomp.to_i
    display_team(input)
  end

  def display_team(team)
    puts "So you definitely selected number #{team}, cool."
    puts "Here is some more info about the Avengers!"
    puts "-" * 20
    puts "location: Avengers HQ"
    puts "Big foes: Thanos, Ultron"
    puts "Core Avengers members:"
    puts "1. Thor"
    puts "2. Hulk"
    puts "3. Iron Man"
    puts "4. Captain America"
    puts "Select a number from the options above to learn more!"
    input = gets.chomp.to_i
    display_character("thor")
  end

  def display_character(character)
    puts "Hi I'm thor! (You definitely selected this)"
    puts "I have a cool hammer"
    puts "I'm from asgard, etc etc"
  end

end
