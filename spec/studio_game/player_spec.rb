require 'studio_game/spec_helper'
require 'studio_game/player'
require 'studio_game/treasure_trove'

module StudioGame
  describe Player do 
    before do 
      @initial_health = 150
      @name = "sam"
      @player = Player.new(@name, @initial_health)
    end

    it "has a capitalized title" do
      expect(@player.name).to eq(@name.capitalize)
    end

    it "has a initial health" do
      expect(@player.health).to eq(@initial_health)
    end

    it "has a string representation" do
      expect(@player.to_s).to eq("I'm Sam with a health of 150 and a score of 150.")
    end

    it "computes a score as the sum of its health and length of name" do
      expect(@player.score).to eq(@player.points + @initial_health)
    end

    it "increases health by 15 when w00ted" do
      @player.w00t
      expect(@player.health).to eq(@initial_health + 15)
    end

    it "decreases health by 10 when blammed" do
      @player.blam
      expect(@player.health).to eq(@initial_health - 10)
    end

      
    context "with a health greater then 100" do
      before do 
        @player = Player.new("sam", 150)
      end

      it "is strong" do
        expect(@player).to be_strong
      end
    end

    context "with a health of 100 or less" do 
      before do
        @player = Player.new("sam", 80)
      end

      it "is Wimpy" do 
        expect(@player).not_to be_strong
      end
    end

    context "in a collection of players" do
      before do
        @player1 = Player.new("moe",   100)
        @player2 = Player.new("larry", 200)
        @player3 = Player.new("curly", 300)
    
        @players = [@player1, @player2, @player3]
      end
    
      it "is sorted by decreasing score" do
        expect(@players.sort).to eq([@player3, @player2, @player1])
      end
    end

    it "computes points as the sum of all treasure points" do
      expect(@player.points).to be_zero

      @player.found_treasure(Treasure.new(:hammer, 50))
    
      expect(@player.points).to eq(50)
    
      @player.found_treasure(Treasure.new(:gold, 200))
    
      expect(@player.points).to eq(250)
    
      @player.found_treasure(Treasure.new(:hammer, 50))
    
      expect(@player.points).to eq(300)
    end

    it "computes a score as the sum of its health and points" do
      @player.found_treasure(Treasure.new(:hammer, 50))
      @player.found_treasure(Treasure.new(:hammer, 50))
    
      expect(@player.score).to eq(250)
    end

    it "yields each found treasure and its total points" do
      @player.found_treasure(Treasure.new(:hammer, 50))
      @player.found_treasure(Treasure.new(:hammer, 50))
      @player.found_treasure(Treasure.new(:hammer, 50))
      @player.found_treasure(Treasure.new(:wood,   10))
      @player.found_treasure(Treasure.new(:wood,   10))
      @player.found_treasure(Treasure.new(:wood,   10))
      @player.found_treasure(Treasure.new(:wood,   10))
      @player.found_treasure(Treasure.new(:wood,   10))
    
      yielded = []
      @player.each_found_treasure do |treasure|
        yielded << treasure
      end
    
      expect(yielded).to  eq([
        Treasure.new(:hammer,  150),
        Treasure.new(:wood,    50)
    ])
    end

    it "can be created from a CSV string" do
      player = Player.from_csv("larry,150")

      expect(player.name).to eq("Larry")
      expect(player.health).to eq(150)
    end
  end
end