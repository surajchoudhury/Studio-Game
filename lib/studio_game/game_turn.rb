require "studio_game/die"
require 'studio_game/treasure_trove'
require 'studio_game/loaded_die'

module GameTurn
  def self.take_turn(player)
    die = LoadedDie.new
    case die.roll
    when 1..2
      player.blam
    when 3..4
      puts "#{player.name} was skipped."
    else
      player.w00t
    end
    treasure = StudioGame::TreasureTrove.random
    player.found_treasure(treasure)
  end
end