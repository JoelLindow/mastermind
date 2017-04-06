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

end
