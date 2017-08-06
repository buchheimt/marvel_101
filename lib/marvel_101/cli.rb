class Marvel101::CLI

  def call
    puts "Welcome to Marvel 101!"
    main_menu
  end

  def list_main_options
    puts "Here are your primary options:"
    puts "1. Popular Teams!"
    puts "2. Popular Heroes!"
    puts "3. Popular Villains!"
    puts "4. Marvel's Currently Featured!"
    puts "5. Women of Marvel!"
    puts "6. Exit Marvel 101"
  end

  def main_menu
    list_main_options
    puts "Select a number from the options above and we'll get started!"
    input = gets.chomp.to_i
    case input
    when 1 then detail_menu("teams")
    when 2 then detail_menu("heroes")
    when 3 then detail_menu("villains")
    when 4 then detail_menu("featured")
    when 5 then detail_menu("women")
    when 6 then puts "Sure thing, have a super day! (haha super... get it?)"
    else
      puts "Yeah... that's not an option. Let's try that again."
      main_menu
    end
  end

  def detail_menu(topic)
    puts "cool you selected #{topic}"
  end

end
