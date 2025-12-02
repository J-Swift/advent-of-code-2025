def load_input
  File.readlines('input.txt').map(&:strip)
end

def parse_input(lines)
  lines
end

def invalid_id?(id)
  str = id.to_s

  str.length.even? && str[0..str.length/2-1] == str[str.length/2..]
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
  # pp invalid
  puts invalid.sum
end

main
