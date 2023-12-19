class Player
  attr_accessor :name,:player_point
  def initialize(name)
    @name = name
    @player_point = 0
  end

  def player_draw_card(deck)
    # deckハッシュの中からランダムなkeyを選ぶ
    random_card_suit = deck.keys.sample
    # ランダムなキーの配列から一つカードを選ぶ
    random_card_number = deck[random_card_suit].sample
    # 選んだカードを配列から削除する
    deck[random_card_suit].delete(random_card_number)
    # 引いたカードのスートと数字を配列化
    card_content = [random_card_suit,random_card_number]
    # 配列と点数を返す
    return card_content
  end
end




