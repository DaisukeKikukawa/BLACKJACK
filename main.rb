# frozen_string_literal: true

require './game'
require './player'
require './dealer'

dealer = Dealer.new('ディーラー')
# 自分を作成
player1 = Player.new('プレーヤー1')
Game.game_start(player1, dealer)
