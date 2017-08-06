class Marvel101::Category

  attr_accessor :name, :url, :topics

  def initialize(name, url)
    @name = name
    @url = url
    @topics = []
  end

  def add_topics
    @topics << Marvel101::Team.new("Avengers")
    @topics << Marvel101::Team.new("X-Men")
    @topics << Marvel101::Team.new("Guardians of the Galaxy")
    @topics << Marvel101::Team.new("Fantastic Four")
    @topics << Marvel101::Team.new("Defenders")
  end

end
