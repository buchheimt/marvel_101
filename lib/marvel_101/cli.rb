class Marvel101::CLI

  def call
    puts "Welcome to Marvel 101!"
    main_menu
  end

  def main_menu
    puts "Let's get started. Enter a corresponding number from the options below:"
    puts "1. Popular Teams!"
    puts "2. Popular Heroes!"
    puts "3. Popular Villains!"
    puts "4. Marvel's Currently Featured!"
    puts "5. Women of Marvel!"
  end

end
