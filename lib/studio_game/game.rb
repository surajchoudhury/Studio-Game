require "studio_game/game_turn"

module StudioGame
  class Game 
    attr_reader :title
    attr_accessor :players

    def initialize(title)
      @title = title
      @players = []
    end

    def load_players(from_file="players.csv")
      File.readlines(from_file).each do |line|
        add_player(Player.from_csv(line))
      end
    end

    def save_high_scores(to_file="high_scores.txt")
      File.open(to_file, "w") do |file|
        file.puts "#{@title} High Scores:"
        @players.sort.each do |player|
          file.puts high_score_entry(player)
        end
      end
    end

    def high_score_entry(player)
      formatted_name = player.name.ljust(20, '.')
      "#{formatted_name} #{player.score}"
    end

    def add_player(player)
      @players << player
    end

    def total_points
      @players.reduce(0) { |sum, player| sum + player.points }
    end

    def print_stats
      strong_players, wimpy_players = @players.partition {|player| player.strong?}

      puts "\n#{@title} Statistics:"

      puts "\n#{strong_players.size} strong players:"
      strong_players.each do |player|
        puts "#{player.name} (#{player.health})"
      end
    
      puts "\n#{wimpy_players.size} wimpy players:"
      wimpy_players.each do |player|
        puts "#{player.name} (#{player.health})"
      end

      puts "\n#{@title} High Scores:"
      @players.sort.each do |player|
        puts high_score_entry(player)
      end
      
      @players.each do |player|
        puts "\n#{player.name}'s point totals:"
        puts "#{player.points} grand total points"

        player.each_found_treasure do |treasure|
          puts "#{treasure.points} total #{treasure.name} points"
        end
      end

      puts "\n#{total_points} total points from treasures found"
    end

    def play(rounds)
    puts "There are #{@players.size} players in #{@title}: "
    @players.each do |player|
      puts player
    end
    1.upto(rounds) do |round|
        puts "\nRound #{round}:"
        @players.each do |player|      
          GameTurn.take_turn(player)
          puts player
        end
      end
    end
  end
end