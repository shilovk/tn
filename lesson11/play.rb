# frozen_string_literal: true

require 'byebug'
require_relative 'user_game'
require_relative 'dealer_game'

UserGame.new('Tom')
DealerGame.new
Game.play
