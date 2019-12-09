# frozen_string_literal: true

# Inteerface
module Interface
  module_function

  def ask_player_name
    p 'Hello! what is your name?'
    gets
  end

  def play_next?(error = nil)
    p error.message if error
    p 'Play next? y - yes'
    return true if gets.chomp == 'y'

    exit
  end

  def info_game_over
    'Gave Over'
  end

  def show_winners
    p 'Winners:'
  end

  def show_no_winners
    p 'No winners'
  end

  def show_players(players = [], cards = [], score = nil)
    [players].flatten.each do |player|
      p player.name
      p player.money
      p "cards: #{cards.join(' ')}" unless cards.empty?
      p "score #{score}" if score
    end
    sleep(2)
  end
end
