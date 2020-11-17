require "studio_game/player"
require "studio_game/treasure_trove"

class ClumsyPlayer < StudioGame::Player  
  def found_treasure(treasure)
    damaged_treasure = StudioGame::Treasure.new(treasure.name, treasure.points / 2.0)
    super(damaged_treasure)
  end
end


  clumsy = ClumsyPlayer.new("klutz")  
  
  hammer = StudioGame::Treasure.new(:hammer, 50)
  clumsy.found_treasure(hammer)
  clumsy.found_treasure(hammer)
  clumsy.found_treasure(hammer)
  
  crowbar = StudioGame::Treasure.new(:crowbar, 400)
  clumsy.found_treasure(crowbar)
  
  clumsy.each_found_treasure do |treasure|
    puts "#{treasure.points} total #{treasure.name} points"
  end
  puts "#{clumsy.points} grand total points"
