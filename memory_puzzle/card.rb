class Card

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
  # def ==
  #
  # end

end
