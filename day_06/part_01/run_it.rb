def load_input
  File.readlines('input.txt').map(&:strip)
  # File.readlines('input_test.txt').map(&:strip)
end

def parse_input(lines)
  lines
end

def main
  lines = parse_input(load_input)

  parsed = lines.map { |line| line.split(' ') }

  res = parsed.transpose.reduce(0) do |memo, val|
    row_val = val[0..-2].map(&:to_i).reduce(val[-1].to_sym)
    memo + row_val
  end

  pp res
end

main
