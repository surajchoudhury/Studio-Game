require "studio_game/spec_helper"
require "studio_game/treasure_trove_spec"

module StudioGame
  describe Treasure do
    before do
      @treasure = Treasure.new(:hammer, 50)
    end

    it "has a name attribute" do
      expect(@treasure.name).to eq(:hammer)
    end

    it "has a point attribute" do
      expect(@treasure.points).to eq(50)
    end
  end 

  describe TreasureTrove do
    it "has six treasures" do
      expect(TreasureTrove::TREASURES.size).to eq(6)
    end
    
    it "has a hammer worth 20 points" do
      expect(TreasureTrove::TREASURES[0]).to eq(Treasure.new(:hammer, 20))
    end
    
    it "has a bottle worth 200 points" do
      expect(TreasureTrove::TREASURES[1]).to eq(Treasure.new(:diamond, 200))
    end
    
    it "has a gold worth 100 points" do
      expect(TreasureTrove::TREASURES[2]).to eq(Treasure.new(:gold, 100))
    end
    
    it "has a platinum worth 150 points" do
      expect(TreasureTrove::TREASURES[3]).to eq(Treasure.new(:platinum, 150))
    end

    it "has a wood worth 10 points" do
      expect(TreasureTrove::TREASURES[4]).to eq(Treasure.new(:wood, 10))
    end
    
    it "has a steal worth 40 points" do
      expect(TreasureTrove::TREASURES[5]).to eq(Treasure.new(:steal, 40))
    end

    it "returns a random treasure" do
      treasure = TreasureTrove.random
      expect(TreasureTrove::TREASURES).to include(treasure)
    end
  end
end