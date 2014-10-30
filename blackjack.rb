#After being dealt the initial 2 cards, the player goes first and can choose to either "hit" or "stay". 
#Hitting means deal another card. If the player's cards sum up to be greater than 21, the player has "busted" and lost.
#If the sum is 21, then the player wins. If the sum is less than 21, 
#then the player can choose to "hit" or "stay" again. 
#If the player "hits", then repeat above, but if the player stays, then the player's total value is saved, 
#and the turn moves to the dealer.
#
#By rule, the dealer must hit until she has at least 17. If the dealer busts, then the player wins. 
#If the dealer, hits 21, then the dealer wins. If, however, the dealer stays, then we compare 
#the sums of the two hands between the player and dealer; higher value wins.

class Card
  	attr_accessor :suit,:value,:status 

  	def initialize(s,v)
  		self.suit = s 
  		self.value = v
  		self.status = 0  
  	end
  	def is_avail()
  		if self.status == 1 then return false
  		else return true 
  		end 
  	end 

end

class Deck
	attr_accessor :current_deck,:suits,:card_values
	#h,d,c,s
	def initialize()
		self.current_deck = []
		self.card_values = []
		(1..10).each do |i| 
			self.card_values.push(i.to_s)
		end 
		self.card_values.push('J')
		self.card_values.push('Q')
		self.card_values.push('K')
		self.suits = ['h','d','c','s']


		for i in 0..(self.suits.length - 1)
			for j in 0..(self.card_values.length - 1) 
				card = Card.new(self.suits[i],self.card_values[j])
				self.current_deck.push(card)
			end 
		end 

	end 
end

class Player
	attr_accessor :hand

	def initialize()
		self.hand = Hand.new
	end 

end

class Dealer
	attr_accessor :hand,:deck

	def initialize(deck)
		self.hand = Hand.new
		self.deck = deck
	end 

	def draw_card()
		draw = false 
		card = Card.new('a','1')
		begin 
			s = rand(3)
			v = rand(12) + 1 
			for i in 0..deck.current_deck.length - 1 
				if (deck.current_deck[i].suit  == deck.suits[s])  && (deck.current_deck[i].value  == deck.card_values[v]) && (deck.current_deck[i].is_avail()) 
					then 
						deck.current_deck[i].status = 1 
						card  = deck.current_deck[i]
						draw = true 
				end 
			end

		end until draw 
		return card
	end 
end

class Hand
	attr_accessor :cards,:total 
	def initialize()
		self.cards = []
		self.total = 0
	end 
	def add(new_card)
		value = self.total 
		if new_card == 'J' || new_card == 'K' || new_card == 'Q'
			value = value + 10 
		elsif new_card == '1'
			if value + 11 > 21 then value = value +1 
			else value + 11
			end
		else value = value + new_card.to_i 
		end
		self.cards.push(new_card)
		self.total  = value
	end 
end

class Game 

	def run() 
		player = Player.new 
		deck = Deck.new 
		dealer = Dealer.new(deck) 
		puts "Game started!"
		card = dealer.draw_card()
		player.hand.add(card.value)
		card = dealer.draw_card()
		player.hand.add(card.value)
		puts "player's card : #{player.hand.cards}"
		card = dealer.draw_card()
		dealer.hand.add(card.value)
		card = dealer.draw_card()
		dealer.hand.add(card.value)
		puts "dealers card : #{dealer.hand.cards}"
		puts "Player's turn : "
		continue = ''
		begin
			puts "hit or stay?"
			continue = gets.chomp
			if continue == 'hit' then
				card = dealer.draw_card()
				player.hand.add(card.value)
				puts "Card draw : #{card.suit} #{card.value}."
				puts "Player's cards : #{player.hand.cards} . Total : #{player.hand.total}"
			end

		end until continue =='stay' or player.hand.total >= 21
		puts "Player card #{player.hand.cards} .  Total : #{player.hand.total}"
		if player.hand.total > 21 then 
			puts "Player busted. Player lost"
		elsif player.hand.total == 21 then 
			puts "Player card #{player.hand.cards}. Player win"
		else
			continue =''
			choice=['hit','stay']
			begin
				continue = choice[rand(1)]
				if continue == 'hit' then
					card = dealer.draw_card()
					dealer.hand.add(card.value)
				elsif dealer.hand.total <= 17 then 
					continue = 'hit'
				end
				puts "Dealer choose to #{continue} "
				puts "Card draw : #{card.suit} #{card.value}."
				puts "Dealer's cards : #{dealer.hand.cards} . Total : #{dealer.hand.total}"

			end until continue =='s' ||  dealer.hand.total >= 21
			puts "Player : #{player.hand.cards}. Total : #{player.hand.total}"
			puts "Dealer : #{dealer.hand.cards}. Total : #{dealer.hand.total}"

			if dealer.hand.total > 21 then 
				puts "Dealer busted. Player win"
			elsif dealer.hand.total == 21 then 
				puts "Dealer card #{dealer.hand.cards}. Player lost"
			else
				if player.hand.total > dealer.hand.total then puts 'Player win'
				elsif player.hand.total > dealer.hand.total then puts 'Tie'
				else puts 'Dealer win'
				end
			end 
		end 



	end 
end 

Game.new.run() 

















