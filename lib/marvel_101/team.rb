require_relative 'concerns/memorable'

class Marvel101::Team
  include Memorable::InstanceMethods
  extend Memorable::ClassMethods

  attr_accessor :name, :url, :category, :members, :details, :description, :url_101,
                :url_wiki

  @@all = []

  def initialize(name, url)
    @scraped = false
    @details = [:description, :url, :url_101, :url_wiki]
    super
  end

  def get_info
    attributes = Marvel101::Scraper.new(@url).scrape_team
    attributes.each {|key, value| self.send("#{key}=", value)}
    if members
      members.each do |member|
        member.category = category;
        member.team = self
      end
    end
    @scraped = true
  end

  def scraped?
    @scraped
  end

  def self.all
    @@all
  end

end
