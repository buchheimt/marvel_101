class Marvel101::Scraper

  attr_accessor :url

  def initialize(url)
    @url = url
  end

  def scrape_category
    topics = []
    doc = Nokogiri::HTML(open(url))
    if doc.css("div#comicsListing div.row-item").size > 0
      item_cards = doc.css("div#comicsListing div.row-item")
    else
      item_cards = doc.css("section#featured-chars div.row-item")
    end
    item_cards.css("div.row-item-text > h5 > a").each do |link|
      name = link.text.strip
      url = link.attr("href")
      if @url.include?("team")
        topics << Marvel101::Team.find_or_create_by_name(name, "http:#{url}")
      else
        topics << Marvel101::Character.find_or_create_by_name(name, "http:#{url}")
      end
    end
    topics
  end

  def scrape_team
    details = {}
    doc = Nokogiri::HTML(open(url))

    details[:description] = description_scrape(doc) if description_scrape(doc)

    members = []
    members_grid = doc.css("div.grid-container").first
    members_grid.css("div.row-item").each do |card|
      name = card.css("a.meta-title").text.strip
      url = "http:#{card.css("a.meta-title").attr("href").value}"
      members << Marvel101::Character.find_or_create_by_name(name, url)
    end
    details[:members] = members
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
    details = {}
    doc = Nokogiri::HTML(open(url))

    details[:description] = description_scrape(doc) if description_scrape(doc)

    raw_details = doc.css("div.featured-item-meta")
    raw_details.css("div div").each do |raw_detail|
      detail = raw_detail.css("strong").text.downcase.strip.split(" ").join("_").to_sym
      if raw_detail.css("p:last-child span").text.strip != ""
        info = raw_detail.css("p:last-child span").text
      else
        info = raw_detail.css("p:last-child").text
      end
      details[detail] = info if raw_detail.css("strong").text.strip != ""
    end
    url_101_text = doc.css("div#MarvelVideo101 script").text
    if url_101_text != ""
      details[:url_101] = "https://www.youtube.com/watch?v=#{url_101_text.match(/videoId: .(\w*)./)[1]}"
    end
    if doc.css("div.title-section a.featured-item-notice.primary").size > 0
      details[:url_wiki] = doc.css("div.title-section a.featured-item-notice.primary").attr("href").value
    end
  details
  end

  def description_scrape(doc)
    raw_description = doc.css("div.featured-item-desc p:nth-child(2)")
    #binding.pry
    if raw_description && raw_description.text.strip != ""
        desc_value = raw_description.text.gsub(/\n\s*more/," ").gsub(/\n\s*less/," ").gsub(/\n\s*/," ").strip
    end
  end

end
