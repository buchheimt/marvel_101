require_relative 'concerns/memorable'

class Marvel101::List
  include Memorable::InstanceMethods
  extend Memorable::ClassMethods

  attr_accessor :name, :scraped, :url, :topics

  @@all = []

  def initialize(name, url)
    @topics = Marvel101::Scraper.new(url).scrape_list
    @topics.each {|topic| topic.list = self}
    @scraped = true
    super
  end

  def display
    topics.each.with_index(1) {|topic, index| puts "#{index}. #{topic.name}"}
  end

  def self.all
    @@all
  end

end
