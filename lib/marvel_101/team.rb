require_relative 'concerns/memorable'

class Marvel101::Team
  include Memorable::InstanceMethods
  extend Memorable::ClassMethods

  attr_accessor :name, :url, :list, :scraped, :members, :details, :description,
                :url_101, :url_wiki

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
        member.list = list;
        member.team = self
      end
    end
    @scraped = true
  end

  def display
    details.each do |detail|
      puts "#{detail.to_s.split("_").join(" ").capitalize}: #{self.send("#{detail}")}" if self.send("#{detail}")
    end
    if members
      puts "Core Members:"
      members.each.with_index(1) {|member, index| puts "    #{index}. #{member.name}"}
    end
  end

  def self.all
    @@all
  end
end
