class Marvel101::Team

  attr_accessor :name, :members, :description, :location

  def initialize(name, members, description, location)
    @name = name
    @members = members
    @description = description
    @location = location
  end

end
