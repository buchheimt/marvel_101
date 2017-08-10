class Marvel101::Scraper

  attr_accessor :topic, :doc

  def initialize(topic)
    @topic = topic
    @url = topic.urls[:url]
  end

  def scrape_list
    get_doc
    get_items(get_item_cards)
  end

  def scrape_topic
    get_doc
    get_description
    topic.team? ? get_members : get_details
    get_101
    get_wiki
  end

  def get_doc
    @doc = Nokogiri::HTML(open(@url))
  end

  def get_item_cards
    item_cards = doc.css("div#comicsListing div.row-item")
    item_cards.size > 0 ? item_cards : doc.css("section#featured-chars div.row-item")
  end

  def get_items(item_cards)
    topic.items = item_cards.css("div.row-item-text > h5 > a").collect do |link|
      name, url = link.text.strip, link.attr("href")
      if @url.downcase.include?("team")
        Marvel101::Team.find_or_create_by_name("The #{name}", "http:#{url}").tap {|team| team.list = topic}
      else
        Marvel101::Character.find_or_create_by_name(name, "http:#{url}").tap {|char| char.list = topic}
      end
    end
  end

  def get_description
    info = doc.css("div.featured-item-desc p:nth-child(2)")
    if info.text.strip != ""
      topic.description = info.text.gsub(/\n\s*([ml][oe][rs][es])?/," ").strip
    end
  end

  def get_members
    members_grid = doc.css("div.grid-container").first
    topic.members = members_grid.css("div.row-item").collect do |card|
      name = card.css("a.meta-title").text.strip
      url = "http:#{card.css("a.meta-title").attr("href").value}"
      Marvel101::Character.find_or_create_by_name(name, url).tap do |member|
        member.list, member.team = topic.list, topic
      end
    end
  end

  def get_details
    topic.details = {}
    raw_details = doc.css("div.featured-item-meta")
    raw_details.css("div div").each do |raw_detail|
      detail = raw_detail.css("strong").text.downcase.strip.split(" ").join("_").to_sym
      info = raw_detail.css("p:last-child span").text.strip
      info != "" ? info : info = raw_detail.css("p:last-child").text
      topic.details[detail.to_sym] = info
    end
  end

  def get_101
    url_101_text = doc.css("div#MarvelVideo101 script").text
    if url_101_text != ""
      topic.urls[:url_101] = "https://www.youtube.com/watch?v=#{url_101_text.match(/videoId: .(-?\w*)./)[1]}"
    end
  end

  def get_wiki
    wiki_link = doc.css("div.title-section a.featured-item-notice.primary")
    topic.urls[:url_wiki] = wiki_link.attr("href").value if wiki_link.size > 0
  end
end
