class GuessEvaluator
attr_accessor :current_guess, :random_sequence

  def initialize
    @current_guess = []
    @random_sequence = []
  end

  def compare_random_to_guess
    random_sequence.each_with_index.map do |letter, i|
      if letter == current_guess[i]
        letter
      else
        "X"
      end
    end
  end

  def count_correct_peg_colors
    color_check = random_sequence.dup
    current_guess.each do |letter|
      if color_check.include?(letter)
        index = color_check.find_index(letter)
        color_check.delete_at(index)
      end
    end
    4 - color_check.count
  end

  def count_correct_peg_positions
    4 - compare_random_to_guess.count("X")
  end
end
