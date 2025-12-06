def load_input
  File.readlines('input.txt').map(&:strip)
  # File.readlines('input_test.txt').map(&:strip)
end

def parse_input(lines)
  lines
end

def main
  lines_iter = parse_input(load_input).each

  fresh = []
  while true
    line = lines_iter.next
    break if line.empty?

    first, last = line.split('-').map(&:to_i)
    fresh << Range.new(first, last)
  end

  # in_stock = Set.new
  total = 0
  while (lines_iter.peek rescue false)
    line = lines_iter.next.to_i
    total += 1 if fresh.any? { |it| it.member?(line) }
    # in_stock = in_stock.add(line)
  end

  puts total
  # puts in_stock.intersection(fresh).count
end

main
