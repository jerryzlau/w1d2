class Tile

  attr_accessor :value, :given

  def initialize(value, given=false)
    @value = value
    @given = given
  end

end
