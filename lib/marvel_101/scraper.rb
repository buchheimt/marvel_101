class Marvel101::Scraper

  attr_accessor :url

  def initialize(url)
    @url = url
  end

  def scrape_category
    topics = []
    doc = Nokogiri::HTML(open(url))
    team_items = doc.css("div#comicsListing div.row-item")
    team_items.css("div.row-item-text > h5 > a").each do |link|
      name = link.text.strip
      url = link.attr("href")
      if @url.include?("team")
        topics << Marvel101::Team.find_or_create_by_name(name, url)
      else
        topics << Marvel101::Character.find_or_create_by_name(name, url)
      end
    end
    topics
  end

  def scrape_team
    details = {}
    doc = Nokogiri::HTML(open("http:#{url}"))

    details[:description] = doc.css("div.featured-item-desc p:nth-child(2)").text.strip if doc.css("div.featured-item-desc p:nth-child(2)")

    members = []
    members_grid = doc.css("div.grid-container").first
    members_grid.css("div.row-item").each do |card|
      name = card.css("a.meta-title").text.strip
      url = "http:#{card.css("a.meta-title").attr("href").value}"
      members << Marvel101::Character.find_or_create_by_name(name, url)
    end
    details[:members] = members
    binding.pry
    url_101_text = doc.css("div#MarvelVideo101 script").text
    if url_101_text != ""
      details[:url_101] = "https://www.youtube.com/watch?v=#{url_101_text.match(/videoId: .(\w*)./)[1]}"
    end
    if doc.css("div.title-section a.featured-item-notice.primary").size > 0
      details[:url_wiki] = doc.css("div.title-section a.featured-item-notice.primary").attr("href").value
    end
    details
  end

  def scrape_character
    case url
    when "Spider-Man url"
      {
        description: "Friendly neighborhood spider-man",
        powers: "super senses",
        abilities: "wall climbing, web",
        groups: "Avengers",
        first_app: "Amazing Fantasy #15",
        origin: "Amazing Fantasy #15",
        url_101: "spidey 101 url",
        url_wiki: "spidey wiki url"
      }
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
