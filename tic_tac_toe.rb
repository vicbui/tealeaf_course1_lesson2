#tic tac toe games 

class Player 
	attr_accessor :position
end 

class Human < Player 
	def pick_a_position()
		begin 
			self.position = gets.chomp.to_i 
		end until self.position >= 1 && self.position <= 9
	end 
end 

class Computer < Player 
	def pick_a_position()
		self.position = rand(8) + 1 
	end 
end 

class Board 
	attr_accessor :board 
	def initialize()
		self.board = [' ',' ',' ',' ',' ',' ',' ',' ',' ',' ']
	end 
	def is_empty(position)
		empty = true
		if self.board[position] == 'X' || self.board[position] == 'O' then 
			empty = false 
		end 
		return empty
	end 
	def is_finished()
		if (((self.board[1] == self.board[2]) && (self.board[2] == self.board[3]) && (self.board[2] != ' ' ) \
			|| ((self.board[1] == self.board[5]) && (self.board[5] == self.board[9]) && (self.board[1] != ' ')) \
			|| ((self.board[1] == self.board[4]) && (self.board[4] == self.board[7]) && (self.board[1] != ' ')) \
			|| ((self.board[2] == self.board[5]) && (self.board[5] == self.board[8]) && (self.board[2] != ' ')) \
			|| ((self.board[3] == self.board[6]) && (self.board[6] == self.board[9]) && (self.board[3] != ' ')) \
			|| ((self.board[3] == self.board[5]) && (self.board[5] == self.board[7]) && (self.board[3] != ' ')) \
			|| ((self.board[4] == self.board[5]) && (self.board[5] == self.board[6]) && (self.board[4] != ' ')) \
			|| ((self.board[7] == self.board[8]) && (self.board[8] == self.board[9])) && (self.board[7] != ' ')))  then 
			return true 

		else
			return false 
		end

	end
	def draw_board()
		system("clear")
		puts "     |     |     "
		puts "  #{self.board[1]}  |  #{self.board[2]}  |  #{self.board[3]}  "
		puts "     |     |     "
		puts "-----+-----+-----"
		puts "     |     |     "
		puts "  #{self.board[4]}  |  #{self.board[5]}  |  #{self.board[6]}  "
		puts "     |     |     "
		puts "-----+-----+-----"
		puts "     |     |     "
		puts "  #{self.board[7]}  |  #{self.board[8]}  |  #{self.board[9]}  "
		puts "     |     |     "
		puts "-----+-----+-----"
	end
end 

class Game 
	def run()
		player1 = Human.new
		player2 = Computer.new
		board = Board.new() 
		turn = true
		while board.is_finished() == false 
			board.draw_board()
			if turn then 
				begin
					puts("Choose a position (from 1 to 9) to place a piece")
					player1.pick_a_position
					if board.is_empty(player1.position) == false then
						puts "Pick another postion"
					end
				end until board.is_empty(player1.position)
				board.board[player1.position] = 'X'
			else
				begin
					player2.pick_a_position()
				end until board.is_empty(player2.position)
				board.board[player2.position] = 'O'
			end  

			turn = !turn
		end 

		board.draw_board()
		if !turn then 
			puts "player won"
		else 
			puts "computer won"
		end
	end 
end 

a = Game.new
a.run()

