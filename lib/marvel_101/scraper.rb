class Marvel101::Scraper

  attr_accessor :topic, :doc

  def initialize(topic)
    @topic = topic
    @url = topic.urls[:url]
  end

  def scrape_list
    @doc = Nokogiri::HTML(open(@url))
    if doc.css("div#comicsListing div.row-item").size > 0
      item_cards = doc.css("div#comicsListing div.row-item")
    else
      item_cards = doc.css("section#featured-chars div.row-item")
    end

    topic.items = item_cards.css("div.row-item-text > h5 > a").collect do |link|
      name = link.text.strip
      url = link.attr("href")
      if @url.downcase.include?("team")
        Marvel101::Team.find_or_create_by_name("The #{name}", "http:#{url}").tap do |team|
          team.list = topic
        end
      else
        Marvel101::Character.find_or_create_by_name(name, "http:#{url}").tap do |character|
          character.list = topic
        end
      end
    end
  end

  def scrape_topic
    @doc = Nokogiri::HTML(open(@url))

    get_description
    topic.is_a?(Marvel101::Team) ? get_members : get_details
    
    url_101_text = doc.css("div#MarvelVideo101 script").text
    if url_101_text != ""
      topic.urls[:url_101] = "https://www.youtube.com/watch?v=#{url_101_text.match(/videoId: .(\w*)./)[1]}"
    end
    wiki_link = doc.css("div.title-section a.featured-item-notice.primary")
    topic.urls[:url_wiki] = wiki_link.attr("href").value if wiki_link.size > 0
  end

  def get_description
    info = doc.css("div.featured-item-desc p:nth-child(2)")
    if info && info.text.strip != ""
      topic.description = info.text.gsub(/\n\s*([ml][oe][rs][es])?/," ").strip
    end
  end

  def get_members
    members_grid = doc.css("div.grid-container").first
    topic.members = members_grid.css("div.row-item").collect do |card|
      name = card.css("a.meta-title").text.strip
      url = "http:#{card.css("a.meta-title").attr("href").value}"
      Marvel101::Character.find_or_create_by_name(name, url).tap do |member|
        member.list = topic.list
        member.team = topic
      end
    end
  end

  def get_details
    topic.details = {}
    raw_details = doc.css("div.featured-item-meta")
    raw_details.css("div div").each do |raw_detail|
      detail = raw_detail.css("strong").text.downcase.strip.split(" ").join("_").to_sym
      if raw_detail.css("p:last-child span").text.strip != ""
        info = raw_detail.css("p:last-child span").text
      else
        info = raw_detail.css("p:last-child").text
      end
      topic.details[detail.to_sym] = info
    end
  end
end
