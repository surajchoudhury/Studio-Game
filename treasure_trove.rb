Treasure = Struct.new(:name, :points)

module TreasureTrove
  TREASURES = [
    Treasure.new(:hammer,   20),
    Treasure.new(:diamond,  200),
    Treasure.new(:gold,     100),
    Treasure.new(:platinum, 150),
    Treasure.new(:wood,     10),
    Treasure.new(:steal,    40)
  ]

  def self.random
    TREASURES.sample
  end
end