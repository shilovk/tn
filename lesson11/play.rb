# frozen_string_literal: true

require 'pry'
require_relative 'user_game'
require_relative 'dealer_game'

user_game = UserGame.new('Tom')
dealer_game = DealerGame.new
Game.play
