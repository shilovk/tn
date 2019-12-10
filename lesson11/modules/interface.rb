# frozen_string_literal: true

# Inteerface
module Interface
  module_function

  @@player_info = proc do |player, args|
    args = args.flatten[0] || {}
    p "player: #{player.name}"
    p "money: #{player.money}" if args[:score]
    p "cards: #{args[:cards].join(' ')}" if args[:cards]
    p "score: #{args[:score]}" if args[:score]
  end

  def ask_player_name
    p 'Hello! what is your name?'
    gets
  end

  def play_next?(error = nil)
    puts
    p error.message if error
    p 'Play next? y - yes'
    return true if gets.chomp == 'y'

    puts 'exit'
    exit
  end

  def show_taking(name)
    puts
    p "#{name}, you are taking a card..."
    puts
    sleep(1)
  end

  def choose_step(steps, player, *args)
    show_player(player, args)
    p "#{player.name}, please choose the step:"
    steps.each { |step| p "#{step} - step '#{step}'" }
    gets.chomp
  end

  def info_game_over
    'Gave Over'
  end

  def info_three_cards
    'All players have three cards'
  end

  def show_winners
    puts
    p 'Winners:'
  end

  def show_no_winners
    puts
    p 'No winners'
  end

  def show_player(player, *args)
    puts
    p 'Actual information:'
    @@player_info.call(player, args)
    puts
    sleep(2)
  end
end
