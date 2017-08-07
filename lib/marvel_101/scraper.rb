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
      topics << Marvel101::Character.new("Thor")
      topics << Marvel101::Character.new("Spider-Man")
      topics << Marvel101::Character.new("Iron Man")
      topics << Marvel101::Character.new("The Hulk")
    when "Popular Villains url"
      topics << Marvel101::Character.new("Ultron")
      topics << Marvel101::Character.new("Thanos")
      topics << Marvel101::Character.new("Green Goblin")
      topics << Marvel101::Character.new("Loki")
    when "Featured Characters url"
      topics << Marvel101::Character.new("Black Panther")
      topics << Marvel101::Character.new("Spider-Man")
      topics << Marvel101::Character.new("Luke Cage")
      topics << Marvel101::Character.new("Iron Fist")
    when "Women of Marvel url"
      topics << Marvel101::Character.new("Black Widow")
      topics << Marvel101::Character.new("Storm")
      topics << Marvel101::Character.new("Captain Marvel")
      topics << Marvel101::Character.new("She-Hulk")
    end
    topics
  end

end
