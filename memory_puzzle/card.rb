class Card

  attr_reader :value
  attr_accessor :show 

  def initialize(value, show=false)
    @value = value
    @show = show
  end

  def hide
    @show = false
  end

  def reveal
    @show = true
  end

  # def to_s
  #
  # end
  #

  def equal(card_two)
    self.value == card_two.value
  end

end
