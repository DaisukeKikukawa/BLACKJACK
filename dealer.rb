# frozen_string_literal: true

class Dealer
  attr_accessor :name, :dealer_point

  def initialize(name)
    @name = name
    @dealer_point = 0
  end

  def dealer_draw_card(deck)
    random_card_suit = deck.keys.sample
    random_card_number = deck[random_card_suit].sample
    deck[random_card_suit].delete(random_card_number)
    [random_card_suit, random_card_number]
  end
end
