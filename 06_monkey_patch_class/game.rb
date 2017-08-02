class Game

  def initialize title, price
    @title, @price = title, price
  end

  def inspect
    "#{@title}: #{@price}"
  end

end

game1 = Game.new('game 1', 199)
p game1

module GameExt
  def on_sale
    'on_sale'
  end
end

ObjectSpace.each_object(Game) do |o|
  o.extend(GameExt)
end

p game1.on_sale

# error
p Game.new('game 2', 199).on_sale
