class Marvel101::Scraper

  attr_accessor :url

  def initialize(url)
    @url = url
  end

  def scrape_category
    topics = []
    case url
    when "Popular Teams url"
      topics << Marvel101::Team.new("Avengers", "Avengers url")
      topics << Marvel101::Team.new("X-Men", "X-Men url")
      topics << Marvel101::Team.new("Guardians of the Galaxy", "Guardians of the Galaxy url")
    when "Popular Heroes url"
      topics << Marvel101::Character.new("Thor", "Thor url")
      topics << Marvel101::Character.new("Spider-Man", "Spider-Man url")
      topics << Marvel101::Character.new("Iron Man", "Iron Man url")
      topics << Marvel101::Character.new("The Hulk", "The Hulk url")
    when "Popular Villains url"
      topics << Marvel101::Character.new("Ultron", "Ultron url")
      topics << Marvel101::Character.new("Thanos", "Thanos url")
      topics << Marvel101::Character.new("Green Goblin", "Green Goblin url")
      topics << Marvel101::Character.new("Loki", "Loki url")
    when "Featured Characters url"
      topics << Marvel101::Character.new("Black Panther", "Black Panther url")
      topics << Marvel101::Character.new("Spider-Man", "Spider-Man url")
      topics << Marvel101::Character.new("Luke Cage", "Luke Cage url")
      topics << Marvel101::Character.new("Iron Fist", "Iron Fist url")
    when "Women of Marvel url"
      topics << Marvel101::Character.new("Black Widow", "Black Widow url")
      topics << Marvel101::Character.new("Storm", "Storm url")
      topics << Marvel101::Character.new("Captain Marvel", "Captain Marvel url")
      topics << Marvel101::Character.new("She-Hulk", "She-Hulk url")
    end
    topics
  end

  def scrape_team
    case url
    when "Avengers url"
      members = []
      member_names = ["Thor", "The Hulk", "Iron Man", "Captain America"]
      member_names.each {|char| members << Marvel101::Character.new(char, "#{char} url")}
      {members: members, description: "THE super team", location: "Avengers HQ"}
    when "X-Men url"
      members = []
      member_names = ["Wolverine", "Cyclops", "Jean Gray"]
      member_names.each {|char| members << Marvel101::Character.new(char, "#{char} url")}
      {members: members, description: "Vast team of gifted mutants", location: "Xavier's Academy"}
    when "Guardians of the Galaxy url"
      members = []
      member_names = ["Groot", "Star Lord", "Drax"]
      member_names.each {|char| members << Marvel101::Character.new(char, "#{char} url")}
      {members: members, description: "Intergalactic band of misfits", location: "The universe"}
    end
  end

  def scrape_character
    case url
    when "Thor url"
      {description: "God of Thunder", powers: "super hammer and strength etc."}
    when "The Hulk url"
      {description: "Angry big giant", powers: "super strength"}
    when "Star Lord url"
      {description: "GoG captain, son of ego", powers: "unclear"}
    when "Loki url"
      {description: "God of Mischief"}
    else
      {}
    end
  end

end
