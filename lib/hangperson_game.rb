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
  
  attr_accessor :word, :guesses, :wrong_guesses
  
  def guess(letter)
    if letter.nil? || letter.length == 0 || !letter.match(/\w/)
      throw Exception
    end
    if @guesses.include?(letter.downcase) || @wrong_guesses.include?(letter.downcase)
      false
    elsif @word.downcase.include?(letter.downcase)
      @guesses += letter.downcase
      true
    else
      @wrong_guesses += letter.downcase
      true
    end
  end
  
  def check_win_or_lose
    if word_with_guesses == @word
      :win
    elsif @wrong_guesses.length < 7
      :play
    else
      :lose
    end
  end
  
  def word_with_guesses()
    retstring = ''
    @word.each_char do |letter|
      if @guesses.include?(letter)
        retstring += letter
      else 
        retstring += '-'
      end
    end
    retstring
  end
  
  # You can test it by running $ bundle exec irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> HangpersonGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.new('watchout4snakes.com').start { |http|
      return http.post(uri, "").body
    }
  end

end


hp = HangpersonGame.new("twiddle")

hp.guess("d")
puts hp.word_with_guesses