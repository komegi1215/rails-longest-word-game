require "open-uri"
require "json"

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score
    @search = params[:search]
    @letters = params[:letters]

    if @search.present?
      @search = @search.upcase
      url = "https://wagon-dictionary.herokuapp.com/#{@search}"
      @word = JSON.parse(URI.open(url).read)

      if @search.chars.all? { |letter| @letters.count(letter) >= @search.count(letter) }
        @message = "Congratulations! #{@search} is a valid English word"
      elsif @search.chars.all? { |letter| @letters.include?(letter) } && @word["found"] == false
        @message = "Sorry but #{@search} does not seem to be a valid English word..."
      else
        @message = "Sorry but #{@search} can't be built out of #{@letters}"
      end
    else
      @message = "please enter a word"
    end
  end
end
