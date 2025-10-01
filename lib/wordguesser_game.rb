class WordGuesserGame
  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/wordguesser_game_spec.rb pass.

  # Get a word from remote "random word" service
  attr_accessor :word, :guesses, :wrong_guesses
  def initialize(word)
    @word = word
    @wrong_guesses = ''
    @guesses = ''
  end

  def guess(letter)
	if letter.nil?|| letter == '' || !letter.match(/[a-zA-Z]/)
	  raise ArgumentError
	end
	dnew=letter.downcase
	if @guesses.include?(dnew) || @wrong_guesses.include?(dnew)
	  return false
	end
	
	if @word.include?(dnew)
	  @guesses=@guesses+dnew
	else
	  @wrong_guesses = @wrong_guesses+dnew
	end
	return true
  end

  def word_with_guesses
	show = ''
	@word.each_char do |char|
	  if @guesses.include?(char)
	    show = show +char
	  else
	    show = show + '-'
	  end
	end
	return show
  end

  def check_win_or_lose
	final = true
	@word.each_char do |char| 
	  if !@guesses.include?(char)
	    final = false
	    break
	  end
	end
	
	if final
	  return :win
	end
	if @wrong_guesses.length >= 7
	  return :lose
	end
	return :play
  end
  # You can test it by installing irb via $ gem install irb
  # and then running $ irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> WordGuesserGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://randomword.saasbook.info/RandomWord')
    Net::HTTP.new('randomword.saasbook.info').start do |http|
      return http.post(uri, "").body
    end
  end
end
