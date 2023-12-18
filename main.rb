deck = {
  'ハート' => ["A", 2, 3, 4, 5, 6, 7, 8, 9, 10, "J", "Q", "K"],
  'スペード' => ["A", 2, 3, 4, 5, 6, 7, 8, 9, 10, "J", "Q", "K"],
  'クラブ' => ["A", 2, 3, 4, 5, 6, 7, 8, 9, 10, "J", "Q", "K"],
  'ダイヤ' => ["A", 2, 3, 4, 5, 6, 7, 8, 9, 10, "J", "Q", "K"]
}

def player_draw_card(deck,player_point)
  # deckハッシュの中からランダムなkeyを選ぶ
  random_card_suit = deck.keys.sample
  # ランダムなキーの配列から一つカードを選ぶ
  random_card_number = deck[random_card_suit].sample
  # 選んだカードを配列から削除する
  deck[random_card_suit].delete(random_card_number)
  # 引いたカードのスートと数字を配列化
  card_content = [random_card_suit,random_card_number]
  # 配列と点数を返す
  return card_content,score_calculation(random_card_number,player_point)
end

def dealer_draw_card(deck,dealer_point)
  random_card_suit = deck.keys.sample
  random_card_number = deck[random_card_suit].sample
  deck[random_card_suit].delete(random_card_number)
  card_content = [random_card_suit,random_card_number]
  return card_content,score_calculation(random_card_number,dealer_point)
end

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

def check_player_max_point(player_point)
  if player_point > 21
    return true
  else
    return false
  end
end

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

first_turn = true  # 1ターン目の判定をするフラグ
game_over = false  # 外側のループを制御するためのフラグ
player_point = 0
dealer_point = 0
while true do
  if first_turn
    puts "ブラックジャックを開始します。"
    first_player_card = player_draw_card(deck,player_point)
    player_point += first_player_card[1]
    puts "あなたの引いたカードは#{first_player_card[0][0]}の#{first_player_card[0][1]}です"
    second_player_card = player_draw_card(deck,player_point)
    player_point += second_player_card[1]
    puts "あなたの引いたカードは#{second_player_card[0][0]}の#{second_player_card[0][1]}です"
    first_dealer_card = dealer_draw_card(deck,dealer_point)
    dealer_point += first_dealer_card[1]
    puts "ディーラーの引いたカードは#{first_dealer_card[0][0]}の#{first_dealer_card[0][1]}です"
    second_dealer_card = dealer_draw_card(deck,dealer_point)
    dealer_point += second_dealer_card[1]
    puts "ディーラーの引いた2枚目のカードはわかりません。"
    first_turn = false
  end

  while true do
    if check_player_max_point(player_point)
      puts "21を超えてしまいました。あなたの負けです。"
      game_over = true
      break
    end

    puts "あなたの現在の得点は#{player_point}です。カードを引きますか？（Y/N）"
    input = gets.chomp

    if input == "Y"
      player_cards = player_draw_card(deck,player_point)
      player_point += player_cards[1]
      puts "あなたの引いたカードは#{player_cards[0][0]}の#{player_cards[0][1]}です"
    else
      break
    end
  end

  puts "ディーラーの引いた2枚目のカードは#{second_dealer_card[0][0]}の#{second_dealer_card[0][1]}です"

  break if game_over

  while dealer_point < 17
    dealer_cards = dealer_draw_card(deck,dealer_point)
    dealer_point += dealer_cards[1]
    puts "ディーラーの引いたカードは#{dealer_cards[0][0]}の#{dealer_cards[0][1]}です"
  end

  puts "あなたの得点は#{player_point}です。"
  puts "ディーラーの得点は#{dealer_point}です。"
  determine_winner(player_point,dealer_point)
  puts "ブラックジャックを終了します"
  break
end
