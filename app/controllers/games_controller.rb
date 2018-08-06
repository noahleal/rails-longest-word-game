class GamesController < ApplicationController
  require 'open-uri'
  require 'json'

  def new
    @letters = []
    alphabet = ('A'..'Z').to_a
    10.times { |x| @letters << alphabet.sample }
  end



  def score
    @word = params[:input]
    @letters = params[:letters]
    dictionary = open("https://wagon-dictionary.herokuapp.com/#{@word}").read
    dictionary_hash = JSON.parse(dictionary)
    @result = {}
    if @word.chars.all? { |letter| @word.count(letter) <= @letters.count(letter) } == false
      @result[:message] = "Your word was not in the grid"
    elsif dictionary_hash["found"]
      @result[:message] = "well done."
    elsif dictionary_hash["found"] != true
    @result[:message] = "That was not an English word you bimbo."
    end
  end
end
