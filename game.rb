require './player.rb'

class Game
  @@deck = {
    'ハート' => ["A", 2, 3, 4, 5, 6, 7, 8, 9, 10, "J", "Q", "K"],
    'スペード' => ["A", 2, 3, 4, 5, 6, 7, 8, 9, 10, "J", "Q", "K"],
    'クラブ' => ["A", 2, 3, 4, 5, 6, 7, 8, 9, 10, "J", "Q", "K"],
    'ダイヤ' => ["A", 2, 3, 4, 5, 6, 7, 8, 9, 10, "J", "Q", "K"]
  }

  class << self
    # 文字列も含め引いたカードによって点数を決めるメソッド
    def score_calculation(random_card_number,player_or_dealer_point)
      if (random_card_number == "J") || (random_card_number == "Q") || (random_card_number == "K")
        return 10
      elsif (random_card_number == "A")
        if player_or_dealer_point + 11 <= 21
          return 11
        else
          return 1
        end
      else
        return random_card_number
      end
    end

    # 21を超えたか判断するメソッド
    def check_player_max_point(player_point)
      if player_point > 21
        return true
      else
        return false
      end
    end

    # 勝敗を決めるメソッド
    def determine_winner(player_point, dealer_point)
      if player_point > 21
        puts "ディーラーの勝ちです。"
      elsif dealer_point > 21
        puts "プレイヤーの勝ちです。"
      elsif player_point == dealer_point
        puts "引き分けです。"
      else
        puts player_point > dealer_point ? "プレイヤーの勝ちです。" : "ディーラーの勝ちです。"
      end
    end

    def choose_player_number
        puts "プレーヤーの人数を決めて下さい"
        number_of_player_input = gets.to_i
        Player.create(number_of_player_input)
    end

    # ゲーム実行開始メソッド
    def game_start(player1,dealer)
      # プレーヤーの人数を決めるメソッド呼び出し
      Game.choose_player_number

      first_turn = true  # 1ターン目の判定をするフラグ
      game_over = false  # 外側のループを制御するためのフラグ
      while true do
        if first_turn
          puts "ブラックジャックを開始します。"
          # first_player_cardに["スート","数字"]の配列がリターンされる
          first_player_card = player1.player_draw_card(@@deck)
          player1.player_point += Game.score_calculation(first_player_card[1],player1.player_point)
          puts "あなたの引いたカードは#{first_player_card[0]}の#{first_player_card[1]}です"
          second_player_card = player1.player_draw_card(@@deck)
          player1.player_point += Game.score_calculation(second_player_card[1],player1.player_point)
          puts "あなたの引いたカードは#{second_player_card[0]}の#{second_player_card[1]}です"
          sleep(1)

          # 追加プレーヤー分の処理ここから
          Player.players.each_with_index do |player, index|
            puts "他プレーヤーのターンです"
            sleep(1)
            first_player_card = player.player_draw_card(@@deck)
            player.player_point += Game.score_calculation(first_player_card[1],player.player_point)
            puts "player#{index + 1}の引いたカードは#{first_player_card[0]}の#{first_player_card[1]}です"
            sleep(1)
            second_player_card = player.player_draw_card(@@deck)
            player.player_point += Game.score_calculation(second_player_card[1],player.player_point)
            puts "player#{index + 1}の引いたカードは#{second_player_card[0]}の#{second_player_card[1]}です"
            sleep(1)
          end
          # 追加プレーヤー分の処理ここまで

          first_dealer_card = dealer.dealer_draw_card(@@deck)
          dealer.dealer_point += Game.score_calculation(first_dealer_card[1],dealer.dealer_point)
          puts "ディーラーの引いたカードは#{first_dealer_card[0]}の#{first_dealer_card[1]}です"
          second_dealer_card = dealer.dealer_draw_card(@@deck)
          dealer.dealer_point += Game.score_calculation(second_dealer_card[1],dealer.dealer_point)
          puts "ディーラーの引いた2枚目のカードはわかりません。"
          first_turn = false
        end

        while true do
          if check_player_max_point(player1.player_point)
            puts "21を超えてしまいました。あなたの負けです。"
            game_over = true
            break
          end

          puts "あなたの現在の得点は#{player1.player_point}です。カードを引きますか？（Y/N）"
          input = gets.chomp

          if input == "Y"
            player_cards = player1.player_draw_card(@@deck)
            player1.player_point += Game.score_calculation(player_cards[1],player1.player_point)
            puts "あなたの引いたカードは#{player_cards[0]}の#{player_cards[1]}です"
          else
            break
          end
        end

        puts "ディーラーの引いた2枚目のカードは#{second_dealer_card[0]}の#{second_dealer_card[1]}です"

        break if game_over

        Player.players.each_with_index do |player, index|
          while player.player_point < 21
            first_player_card = player.player_draw_card(@@deck)
            player.player_point += Game.score_calculation(first_player_card[1],player.player_point)
            puts "player#{index + 1}の引いたカードは#{first_player_card[0]}の#{first_player_card[1]}です"
            sleep(1)
          end
        end

        while dealer.dealer_point < 17
          dealer_cards = dealer.dealer_draw_card(@@deck)
          dealer.dealer_point += Game.score_calculation(dealer_cards[1],dealer.dealer_point)
          puts "ディーラーの引いたカードは#{dealer_cards[0]}の#{dealer_cards[1]}です"
        end

        puts "あなたの得点は#{player1.player_point}です。"
        sleep(1)
        puts "他プレーヤーの得点は"
        Player.players.each_with_index do |player, index|
          puts "player#{index + 1}の得点は#{player.player_point}です。"
        end
        puts "ディーラーの得点は#{dealer.dealer_point}です。"
        sleep(1)
        determine_winner(player1.player_point,dealer.dealer_point)
        sleep(1)
        puts "ブラックジャックを終了します"
        break
      end
    end
  end
end
