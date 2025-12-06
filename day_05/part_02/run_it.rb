def load_input
  File.readlines('input.txt').map(&:strip)
  # File.readlines('input_test.txt').map(&:strip)
end

def parse_input(lines)
  lines
end

def should_combine(a, b)
  return true if a.first == b.first

  if b.first < a.first
    temp = a
    a = b
    b = temp
  end

  return a.last >= b.first
end

def combine_ranges(a, b)
  if b.first < a.first
    temp = a
    a = b
    b = temp
  end

  return Range.new(a.first, a.last >= b.last ? a.last : b.last)
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

  while true
    did_combine = false
    to_consider = fresh.clone
    new_fresh = []

    while !to_consider.empty?
      considering = to_consider.shift
      idx = to_consider.find_index { |it| should_combine(considering, it) }
      if idx
        did_combine = true
        new_fresh << combine_ranges(considering, to_consider.delete_at(idx))
      else
        new_fresh << considering
      end
    end

    fresh = new_fresh
    break unless did_combine
  end

  puts fresh.reduce(0) { |memo, val| memo + val.size }
end

main
