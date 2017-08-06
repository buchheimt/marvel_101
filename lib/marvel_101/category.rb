class Marvel101::Category

  attr_accessor :name, :url, :topics

  def initialize(name, url)
    @name = name
    @url = url
    @topics = []
  end

  def add_topics
    @topics << Marvel101::Team.new("Avengers", ["Thor", "Hulk", "Iron Man", "Captain America"], "THE super team", "Avengers HQ")
    @topics << Marvel101::Team.new("X-Men", ["Wolverine", "Cyclops", "Jean Gray"], "Vast team of gifted mutants", "Xavier's Academy")
    @topics << Marvel101::Team.new("Guardians of the Galaxy", ["Groot", "Star Lord", "Drax"], "Intergalactic band of misfits", "The universe")
    @topics
  end

end
