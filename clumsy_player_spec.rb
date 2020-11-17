require_relative "player_spec"
require_relative "clumsy_player"

describe ClumsyPlayer do
  before do
    @player = ClumsyPlayer.new("klutz")
  end
  
  it "only gets half the point value for each treasure" do
    expect(@player.points).to be_zero

    hammer = Treasure.new(:hammer, 50)
    @player.found_treasure(hammer)
    @player.found_treasure(hammer)
    @player.found_treasure(hammer)

    expect(@player.points).to eq(75)

    gold = Treasure.new(:gold, 400)
    @player.found_treasure(gold)
    
    expect(@player.points).to eq(275)    
    
    yielded = []
    @player.each_found_treasure do |treasure|
      yielded << treasure
    end

    expect(yielded).to eq([Treasure.new(:hammer, 75), Treasure.new(:gold, 200)])
  end

end