def load_input
  File.readlines('input.txt').map(&:strip)
  # File.readlines('input_test.txt').map(&:strip)
end

def parse_input(lines)
  lines
end

DP = Hash.new
def num_timelines(lines, pos)
  while true
    beam_x, beam_y = pos
    next_y = beam_y + 1
    return 1 if next_y >= lines.length

    if lines[next_y][beam_x] != '^'
      pos = [beam_x, next_y]
    else
      left = [beam_x - 1, next_y]
      right = [beam_x + 1, next_y]
      lval = DP[left] || num_timelines(lines, left)
      rval = DP[right] || num_timelines(lines, right)
      DP[left] = lval
      DP[right] = rval
      return lval + rval
    end
  end
end

def main
  lines = parse_input(load_input)

  start = lines[0].split('').find_index { |it| it == 'S' }

  puts num_timelines(lines, [start, 0])
end

main
