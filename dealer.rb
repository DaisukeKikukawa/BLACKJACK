class Dealer
  attr_accessor :name,:dealer_point
  def initialize(name)
    @name = name
    @dealer_point = 0
  end

  def dealer_draw_card(deck)
    random_card_suit = deck.keys.sample
    random_card_number = deck[random_card_suit].sample
    deck[random_card_suit].delete(random_card_number)
    card_content = [random_card_suit,random_card_number]
    return card_content
  end
end
