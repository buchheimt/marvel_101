require_relative 'concerns/memorable'

class Marvel101::List
  include Memorable::InstanceMethods
  extend Memorable::ClassMethods

  attr_accessor :name, :scraped, :url, :topics

  @@all = []

  def initialize(name, url)
    @scraped = false
    super
  end

  def get_info
    Marvel101::Scraper.new(self).scrape_list
    @scraped = true
  end

  def display
    topics.each.with_index(1) {|topic, index| puts "#{index}. #{topic.name}"}
  end

  def self.all
    @@all
  end
end
