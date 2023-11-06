require "open-uri"
class GamesController < ApplicationController
  def new
    @letters = []
    10.times do
      letter = ("a".."z").to_a.sample
      @letters << letter
    end
    @letters = @letters.shuffle.join(" ")
  end
  def score
    # turn params[:letters] into an array
    # compare all of params[:word]to the array
    # if included compare to api
    @letters_array = params[:letters].split(" ")
    @word_array = params[:word].chars
    @validate = @word_array.all? { |word| @letters_array.include?(word)}
    @json = URI.open("https://wagon-dictionary.herokuapp.com/#{params[:word]}").read
    @valid =JSON.parse(@json)["found"]
    # if not, give @answer
    if @validate == true
      if @valid == true
        @answer = "Congratulations! #{params[:word]} is a valid English word!"
        # then english word
      else
        @answer = "Sorry, but #{params[:word]} does not seem to be a valid English word..."
      end
      # not an english word
      # end
    else @answer = "Sorry, but #{params[:word]} can't be built out of #{params[:letters]}"
    end
  end
end
