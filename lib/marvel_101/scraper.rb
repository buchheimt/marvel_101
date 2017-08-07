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
    end
    topics
  end

end
