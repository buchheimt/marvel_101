class Marvel101::Topic

  attr_accessor :name, :description, :urls, :scraped

  LINE_LEN = 80

  @@all = []

  def initialize(name, url)
    @name = name
    @urls = {url: url}
    @scraped = false
    @@all << self
  end

  def get_info
    scraper = Marvel101::Scraper.new(self)
    self.list? ? scraper.scrape_list : scraper.scrape_topic
    @scraped = true
  end

  def display_description
    if description
      format_output("DESCRIPTION: #{description}")
      puts "" if "DESCRIPTION: #{description}".size > 60
    end
  end

  def display_links
    puts "" if urls.size > 1
    ["wiki", "101"].each do |url|
      output = "*Marvel #{url} available! Type '#{url}' to open in browser*"
      puts output if urls.include?("url_#{url}".to_sym)
    end
  end

  def format_output(text)
    i = LINE_LEN
    while i < text.size
      line_break = text[0..i].rindex(" ")
      puts text[i - LINE_LEN...line_break]
      i = line_break + LINE_LEN + 1
    end
    puts text[i - LINE_LEN..-1]
  end

  def takes_input?
    list? || (team? && !members.empty?)
  end

  def has_team?
    char? && team
  end

  def list?
    self.is_a?(Marvel101::List)
  end

  def team?
    self.is_a?(Marvel101::Team)
  end

  def char?
    self.is_a?(Marvel101::Character)
  end

  def self.find_or_create_by_name(name, url)
    search = @@all.detect {|topic| topic.name == name}
    search ? search : self.new(name, url)
  end

  def self.all
    @@all
  end
end
