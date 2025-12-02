def load_input
  # File.readlines('input_test.txt').map(&:strip)
  File.readlines('input.txt').map(&:strip)
end

def parse_input(lines)
  lines
end

def goes_into(len, total)
  return -1 unless total % len == 0

  total / len
end

def invalid_id?(id)
  str = id.to_s

  found = (0..str.length / 2-1).find do |substr_size|
    substr = str[0..substr_size]
    chunk_count = goes_into(substr.length, str.length)
    next unless chunk_count > 0

    str == substr * chunk_count
  end

  !!found
end

def main
  lines = parse_input(load_input)

  ranges = lines[0].split(',').map do |range|
    lower, upper = range.split('-').map(&:to_i)
    Range.new(lower, upper)
  end

  invalid = ranges.reduce([]) do |memo, range|
    range.each { |it| memo << it if invalid_id?(it) }
    memo
  end
  pp invalid
  puts invalid.sum

  # puts invalid_id?(1111)
end

main
