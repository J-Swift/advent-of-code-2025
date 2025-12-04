def load_input
  File.readlines('input.txt').map(&:strip)
  # File.readlines('input_test.txt').map(&:strip)
end

def parse_input(lines)
  lines
end

def max_power(bank)
  prefix = bank[0..-2].each_with_index.reduce({amount: -1, index: -1}) do |memo, (val, index)|
    if val > memo[:amount]
      memo = {amount: val, index: }
    end

    memo
  end

  suffix = bank[prefix[:index]+1..].each_with_index.reduce({amount: -1, index: -1}) do |memo, (val, index)|
    if val > memo[:amount]
      memo = {amount: val, index: }
    end

    memo
  end

  prefix[:amount] * 10 + suffix[:amount]
end

def main
  lines = parse_input(load_input)

  banks = lines.map { |it| it.split('').map(&:to_i) }

  bank = banks.first
  puts banks.map { |it| max_power(it) }.sum
end

main
