require_relative 'board'

class Player
  attr_reader :name, :symbol

  def initialize(name, symbol)
    @name = name
    @symbol = symbol
  end
end

class TicTacToe
  def initialize
    @board = Board.new
    @game_count = 0
  end

  def play
    setup_players

    loop do
      @board.display
      play_game
      @game_count += 1

      puts "Une nouvelle partie ? (o/n)"
      break unless gets.chomp.downcase == "o"

      @board.reset
    end

    puts "Merci d'avoir joué !"
  end

  private

  def setup_players
    puts "Bienvenue au jeu de morpion !\n".colorize(:blue)
    print "Nom du joueur 1 (jouera avec X) : "
    @player1 = Player.new(gets.chomp, "X".colorize(:red))
    print "Nom du joueur 2 (jouera avec O) : "
    @player2 = Player.new(gets.chomp, "O".colorize(:blue))
    @current_player = @player1
  end

  def play_game
    loop do
      @board.display
      player_turn(@current_player)

      if @board.winner?(@current_player.symbol)
        @board.display
        puts "Bravo, #{@current_player.name} a gagné !".colorize(:green)
        break
      elsif @board.full?
        @board.display
        puts "Match nul !".colorize(:yellow)
        break
      end

      switch_player
    end
  end

  def player_turn(player)
    loop do
      print "#{player.name}, entrez une case: "
      position = gets.chomp.upcase

      if valid_move?(position)
        @board.place_symbol(position, player.symbol)
        break
      else
        puts "Case invalide ou déjà occupée, essayez encore.".colorize(:red)
      end
    end
  end

  def valid_move?(position)
    %w[A1 A2 A3 B1 B2 B3 C1 C2 C3].include?(position) && @board.empty?(position)
  end

  def switch_player
    @current_player = @current_player == @player1 ? @player2 : @player1
  end
end