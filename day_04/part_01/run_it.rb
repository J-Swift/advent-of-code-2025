def load_input
  File.readlines('input.txt').map(&:strip)
  # File.readlines('input_test.txt').map(&:strip)
end

def parse_input(lines)
  lines
end

def item_at(board, board_width, board_height, x, y)
  # puts "JIMMY [#{board_width}] [#{board_height}] [#{x}] [#{y}]"
  return 0 unless (0 <= x && x < board_width)
  return 0 unless (0 <= y && y < board_height)

  board[y][x] ? 1 : 0
end

def main
  lines = parse_input(load_input)

  board = lines.map { |line| line.split('').map { |it| it == '@'} }
  width = board[0].length
  height = board.length

  found = []

  board.each_with_index do |row, y_idx|
    row.each_with_index do |cell, x_idx|
      # printf "%s", cell ? '@' : '.'
      # next unless cell
      if !cell
        # printf "."
        next
      end

      is_valid = (
        item_at(board, width, height, x_idx - 1, y_idx - 1) +
        item_at(board, width, height, x_idx, y_idx - 1 ) +
        item_at(board, width, height, x_idx + 1, y_idx - 1) +
        item_at(board, width, height, x_idx - 1, y_idx) +
        item_at(board, width, height, x_idx + 1, y_idx) +
        item_at(board, width, height, x_idx - 1, y_idx + 1) +
        item_at(board, width, height, x_idx, y_idx + 1) +
        item_at(board, width, height, x_idx + 1, y_idx + 1)
      )
      valid = is_valid < 4
      # printf "%s", is_valid

      found << [x_idx, y_idx] if valid
    end
    # printf "\n"
  end

  pp found
  puts found.length
end

main
