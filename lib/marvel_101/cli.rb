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
    puts "cool you selected #{topic}. Right now this is a stub though and I don't care!"
    puts "Here are Marvel's popular teams! (Sorry if your favorite didn't make the cut)"
    puts "1. Avengers"
    puts "2. X-Men"
    puts "3. Guardians of the Galaxy"
    puts "Select a number from the options above to learn more!"
  end

  def display_team()
  end

  def display_character()
  end



end
