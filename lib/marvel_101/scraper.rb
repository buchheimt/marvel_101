class Marvel101::Scraper

  attr_accessor :url

  def initialize(url)
    @url = url
  end

  def scrape_list
    doc = Nokogiri::HTML(open(url))
    if doc.css("div#comicsListing div.row-item").size > 0
      item_cards = doc.css("div#comicsListing div.row-item")
    else
      item_cards = doc.css("section#featured-chars div.row-item")
    end

    item_cards.css("div.row-item-text > h5 > a").collect do |link|
      name = link.text.strip
      url = link.attr("href")
      if @url.downcase.include?("team")
        Marvel101::Team.find_or_create_by_name(name, "http:#{url}")
      else
        Marvel101::Character.find_or_create_by_name(name, "http:#{url}")
      end
    end
  end

  def scrape_team
    details = {}
    doc = Nokogiri::HTML(open(url))

    details[:description] = description_scrape(doc) if description_scrape(doc)

    members_grid = doc.css("div.grid-container").first
    members = members_grid.css("div.row-item").collect do |card|
      name = card.css("a.meta-title").text.strip
      url = "http:#{card.css("a.meta-title").attr("href").value}"
      Marvel101::Character.find_or_create_by_name(name, url, )
    end
    details[:members] = members if members.size > 0
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
    info = doc.css("div.featured-item-desc p:nth-child(2)")
    if info && info.text.strip != ""
      info.text.gsub(/\n\s*([ml][oe][rs][es])?/," ").strip
    end
  end
end
