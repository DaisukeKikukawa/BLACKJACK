# frozen_string_literal: true

require './game'
require './player'
require './dealer'

dealer = Dealer.new('ディーラー')
# 自分を作成
yourself = Player.new('あなた')
Game.game_start(yourself, dealer)
