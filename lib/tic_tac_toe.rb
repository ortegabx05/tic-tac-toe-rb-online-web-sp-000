WIN_COMBINATIONS = [
[0,1,2],
[3,4,5],
[6,7,8],
[0,3,6],
[1,4,7],
[2,5,8],
[0,4,8],
[2,4,6]
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, index, current_player)
  board[index] = current_player
end

def position_taken?(board,index)
 taken = nil
 if (board[index] ==  " " || board[index] == "" || board[index] == nil)
   taken = false
 else
   taken = true
 end
end

def valid_move?(board,index)
  if index.between?(0, 8) && position_taken?(board,index) == false
    true
  else 
    false
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  team = current_player(board)
   if valid_move?(board,index)
    move(board,index,team)
    display_board(board)
   else
    turn(board)
  end
end

def turn_count(board)
  counter = 0
  board.each do |team|
    if team == "X" || team == "O"
      counter += 1
    end
end
return counter
end

def current_player(board)
  if turn_count(board)%2 == 0
    current_player ="X"
  else
    current_player ="O"
end
return current_player
end

def won?(board)
winner = nil
empty_board = board.all? {|x| x == " "}
WIN_COMBINATIONS.each do |winner_combination|
    if empty_board
      return false
    elsif winner_combination.all? { |value| board[value] =="X" } || winner_combination.all? { |value| board[value] =="O" }
      winner = winner_combination
    end
  end
  winner
end

def full?(board)
   board.all? {|position| position == "X" || position == "O"}
end

def draw?(board)
   if !won?(board) && full?(board)
     return true
   else won?(board)
     false
   end
end

def over?(board)
  if full?(board) || won?(board) || draw?(board)
    return true
  else 
    return false
  end
end 

def winner(board)
  if won?(board)
   board[won?(board)[0]]
  end
end

def play(board)
   until over?(board) == true
   turn(board)
 end
  if draw?(board) == true
  puts "Cat's Game!"
  else won?(board)
  puts "Congratulations #{winner(board)}!"
 end
end
