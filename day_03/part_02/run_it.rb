def load_input
  File.readlines('input.txt').map(&:strip)
  # File.readlines('input_test.txt').map(&:strip)
end

def parse_input(lines)
  lines
end

def find_max(bank, starting_idx, ending_idx)
  raise "Invalid indexes [#{starting_idx}] [#{ending_idx}]" if ending_idx < starting_idx
  if ending_idx == starting_idx 
    found = {amount: bank[starting_idx], index: starting_idx}
    # puts "  DIGIT [#{found}]"
    return found
  end

  starting = {amount: bank[ending_idx], index: ending_idx}
  # puts "> FM [#{starting_idx}] [#{ending_idx}]"
  # puts "  START [#{starting}]"
  # printf "  %s\n", bank.join('')
  # printf "  %s%s*\n", (" " * starting_idx), bank.slice(starting_idx, (ending_idx - starting_idx)).join("")

  found = bank.slice(starting_idx, (ending_idx - starting_idx)).reverse.each_with_index.reduce(starting) do |memo, (val, index)|
    real_idx = starting_idx + (ending_idx - starting_idx - 1) - index
    found = false
    if val >= memo[:amount]
      found = true
      memo = {amount: val, index:real_idx}
    end
    # printf "  %s%s\n", (" " * real_idx), found ? '!' : '^'

    memo
  end
  # puts "  DIGIT [#{found}]"
  found
end

def max_power(bank, num_digits)
  starting_idx = 0
  current_digit = 0
  ending_idx = bank.length - num_digits
  vals = bank[ending_idx..]
  digits_remaining = num_digits

  # puts "BANK [#{bank}]"

  while digits_remaining > 0
    found = find_max(bank, starting_idx, ending_idx)
    if found[:index] == ending_idx
      break
    end
    vals[current_digit] = found[:amount]
    current_digit += 1
    ending_idx += 1
    starting_idx = found[:index] + 1
    digits_remaining -= 1
  end
  # first = bank[0..-digits].each_with_index.reduce({amount: -1, index: -1}) do |memo, (val, index)|
  #   if val > memo[:amount]
  #     memo = {amount: val, index: }
  #   end

  #   memo
  # end

  # suffix = bank[prefix[:index]+1..].each_with_index.reduce({amount: -1, index: -1}) do |memo, (val, index)|
  #   if val > memo[:amount]
  #     memo = {amount: val, index: }
  #   end

  #   memo
  # end

  multiplier = 1
  res = vals.reverse.reduce(0) do |memo, val|
    memo = memo + val * multiplier
    multiplier *= 10
    memo
  end
  # puts "RES: #{res}"
  res
end

def main
  lines = parse_input(load_input)

  banks = lines.map { |it| it.split('').map(&:to_i) }

  vals = banks.map { |it| max_power(it, 12) }

  # banks = [[4,2,1,5,3,1]]
  # vals = banks.map { |it| max_power(it, 12) }
  # pp vals
  puts vals.sum
end

main
