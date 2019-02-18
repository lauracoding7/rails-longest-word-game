
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ("A".."Z").to_a.sample }
  end

  def score
    @user_input = params[:user_input]
    url = "https://wagon-dictionary.herokuapp.com/#{@user_input}"
    user_serialized = open(url).read
    hash_url = JSON.parse(user_serialized)
    user_letters = @user_input.upcase.split("")
    @result = {
      message: "Well done!",
      score: (@user_input.length * 3)
    }
    if hash_url["found"] == false
      @result[:score] = 0
      @result[:message] = "Not an English word"
    elsif !user_letters.all? { |letter| user_letters.count(letter) <= params["letters"].split.count(letter) }
      @result[:score] = 0
      @result[:message] = "Not in the grid"
    end
  end
end
