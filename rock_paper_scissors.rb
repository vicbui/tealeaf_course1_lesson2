#player choose a hand and result paper/rock/scior 

class Player 
	attr_accessor :name,:hand 

end 

class Human < Player

	def pick_a_hand(choices)
		self.hand = gets.chomp.downcase
	end 
end 

class Computer < Player 

	def pick_a_hand(choices)
		self.hand = choices[rand(3)]
	end 
end 

class Game 

	def compare(hand1,hand2)
		result = 0 
		if hand1 == hand2 then
			result = 0 
		elsif (hand1=='p' && hand2 =='r') || (hand1=='r' && hand2 =='s') || (hand1=='s' && hand2 =='p') then
			result = 1 
		else result = -1

		end 
		return result			
	end

	def run()
		choices = ['p','r','s']
		puts "Play Paper Rock Scissors !"
		player1 = Human.new
		player2 = Computer.new 
		puts "Enter your name : "
		player1.name = gets.chomp 
		player2.name = "computer"
		again = 'y'

		begin 
			begin
				puts "Choose one : P/R/S"
				player1.pick_a_hand(choices)
			end until player1.hand == 'p' || player1.hand == 'r' || player1.hand == 's'

			player2.pick_a_hand(choices)
			puts "You picks #{player1.hand} and Computer pick #{player2.hand}"
			if compare(player1.hand,player2.hand) > 0 then 
				puts "You won"
			elsif compare(player1.hand,player2.hand) == 0 then 
				puts "It's a tie"
			else puts "You lose"
			
			end 

			puts "Play Again? (Y/N) : "
			again = gets.chomp 
		end until again.downcase == 'n'
	end 


end


Game.new.run()

