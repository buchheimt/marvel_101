module Memorable

  module InstanceMethods

    def initialize(name, url)
      self.name = name
      self.url = url
      self.class.all << self
    end
  end

  module ClassMethods

    def find_or_create_by_name(name, url)
      search = self.all.detect {|topic| topic.name == name}
      search ? search : self.new(name, url)
    end

  end
end
