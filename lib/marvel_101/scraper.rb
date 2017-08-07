class Marvel101::Scraper

  attr_accessor :url

  def initialize(url)
    @url = url
  end

  def scrape_category
    topics = []
    case url
    when "Popular Teams url"
      topics << Marvel101::Team.new("Avengers", ["Thor", "Hulk", "Iron Man", "Captain America"], "THE super team", "Avengers HQ")
      topics << Marvel101::Team.new("X-Men", ["Wolverine", "Cyclops", "Jean Gray"], "Vast team of gifted mutants", "Xavier's Academy")
      topics << Marvel101::Team.new("Guardians of the Galaxy", ["Groot", "Star Lord", "Drax"], "Intergalactic band of misfits", "The universe")
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

  def scrape_character

  end

end
