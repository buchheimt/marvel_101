require_relative 'concerns/memorable'

class Marvel101::List
  include Memorable::InstanceMethods
  extend Memorable::ClassMethods

  attr_accessor :name, :url, :topics

  @@all = []

  def initialize(name, url)
    @topics = Marvel101::Scraper.new(url).scrape_list
    @topics.each {|topic| topic.list = self}
    super
  end

  def self.all
    @@all
  end

end
