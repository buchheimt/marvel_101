class Marvel101::Team

  attr_accessor :name, :members, :description, :location

  def initialize(name, members, description, location)
    @name = name
    @members = []
    @description = description
    @location = location
    members.each {|char| @members << Marvel101::Character.new(char)}
  end

end
