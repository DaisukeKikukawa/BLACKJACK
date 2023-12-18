require './game.rb'
require './player.rb'
require './dealer.rb'

dealer = Dealer.new('ディーラー')
player1 = Player.new('プレーヤー1')
Game.game_start(player1,dealer)
