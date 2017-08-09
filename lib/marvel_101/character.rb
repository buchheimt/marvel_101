require_relative 'concerns/memorable'

class Marvel101::Character
  include Memorable::InstanceMethods
  extend Memorable::ClassMethods

  attr_accessor :name, :url, :list, :team, :details, :description, :real_name, :height, :weight, :powers, :abilities, :group_affiliations, :first_appearance, :origin, :url_101, :url_wiki

  @@all = []

  def initialize(name, url)
    @scraped = false
    @details = [:real_name, :description, :height, :weight, :powers, :abilities, :group_affiliations, :first_appearance, :origin, :url, :url_101, :url_wiki]
    super
  end

  def get_info
    attributes = Marvel101::Scraper.new(@url).scrape_character
    attributes.each {|key, value| self.send("#{key}=", value)}
    @scraped = true
  end

  def scraped?
    @scraped
  end

  def self.all
    @@all
  end

end
