def load_input
  File.readlines('input.txt').map(&:strip)
  # File.readlines('input_test.txt').map(&:strip)
end

def parse_input(lines)
  lines
end

def main
  lines = parse_input(load_input)

  start = lines[0].split('').find_index { |it| it == 'S' }
  current_beams = Set.new([[start, 0]])
  splits = 0

  while !current_beams.empty?
    new_beams = Set.new

    current_beams.each do |(beam_x, beam_y)|
      next_y = beam_y + 1
      next if next_y >= lines.length

      if lines[next_y][beam_x] != '^'
        new_beams << [beam_x, next_y]
      else
        splits += 1
        new_beams << [beam_x - 1, next_y]
        new_beams << [beam_x + 1, next_y]
      end
    end

    current_beams = new_beams
  end

  puts splits
end

main
