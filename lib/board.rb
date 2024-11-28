class Board
  def initialize
    @grid = {
      "A1" => " ", "A2" => " ", "A3" => " ",
      "B1" => " ", "B2" => " ", "B3" => " ",
      "C1" => " ", "C2" => " ", "C3" => " "
    }
  end

  def display
    puts "\n    1   2   3"
    puts "  |---|---|---|"
    puts "A | #{@grid["A1"]} | #{@grid["A2"]} | #{@grid["A3"]} |"
    puts "  |---|---|---|"
    puts "B | #{@grid["B1"]} | #{@grid["B2"]} | #{@grid["B3"]} |"
    puts "  |---|---|---|"
    puts "C | #{@grid["C1"]} | #{@grid["C2"]} | #{@grid["C3"]} |"
    puts "  |---|---|---|\n\n"
  end

  def empty?(position)
    @grid[position] == " "
  end

  def place_symbol(position, symbol)
    @grid[position] = symbol if empty?(position)
  end

  def winner?(symbol)
    winning_combinations = [
      %w[A1 A2 A3], %w[B1 B2 B3], %w[C1 C2 C3], 
      %w[A1 B1 C1], %w[A2 B2 C2], %w[A3 B3 C3], 
      %w[A1 B2 C3], %w[A3 B2 C1]               
    ]
    winning_combinations.any? do |line|
      line.all? { |position| @grid[position] == symbol }
    end
  end

  def full?
    @grid.values.none? { |cell| cell == " " }
  end

  def reset
    @grid.each_key { |key| @grid[key] = " " }
  end
end