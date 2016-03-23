class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

  attr_accessor :word, :guesses, :wrong_guesses

  def guess(letter)
    if letter.nil? || letter.empty? || letter =~ /[^a-zA-Z]/
      raise ArgumentError
    end
    letter = letter.downcase
    if self.word.include?(letter)
      return false if self.guesses.include?(letter)
      self.guesses << letter 
    else
      return false if self.wrong_guesses.include?(letter)
      self.wrong_guesses << letter
    end

    true
  end

  def word_with_guesses
    mask = ''
    self.word.each_char do |letter|
      if self.guesses.include?(letter)
        mask << letter 
      else
        mask << '-' 
      end
    end

    mask
  end

  def check_win_or_lose
    return :lose if self.wrong_guesses.length >= 7
    self.word.each_char do |letter|
      return :play unless self.guesses.include?(letter)
    end

    :win
  end
end
