def load_input
  File.readlines('input.txt').map(&:strip)
end

def parse_input(lines)
  lines
end

def parse_command(command)
  dir, amount = command[0], command[1..]
  {dir:, amount: amount.to_i}
end

def amount_to_next_0(current, dir)
  case dir
  when 'L'
    current == 0 ? 100 : current
  when 'R'
    100 - current
  end
end

def turn_left_by(current, amount)
  raise 'Invalid amount' if amount >= 100

  case
  when amount == 0
    current
  when current >= amount
    current - amount
  else
    100 - (amount - current)
  end
end

def turn_right_by(current, amount)
  raise 'Invalid amount' if amount >= 100

  case
  when amount == 0
    current
  when current < (100 - amount)
    current + amount
  else
    (amount + current) % 100
  end
end

def new_start(current, command)
  dir, remaining = parse_command(command).values_at(:dir, :amount)

  puts "[#{current}] [#{command}]"

  total_0s = 0

  case dir
  when 'L'
    amount = amount_to_next_0(current, dir)
    puts "  ATN0L #{amount}"
    while amount <= remaining
      total_0s += 1
      current = 0
      remaining -= amount
      amount = 100
    end

    puts "  REML [#{remaining}] [#{current}] [#{total_0s}]"
    current = turn_left_by(current, remaining)
  when 'R'
    amount = amount_to_next_0(current, dir)
    puts "  ATN0R #{amount}"
    while amount <= remaining
      total_0s += 1
      current = 0
      remaining -= amount
      amount = 100
    end

    puts "  REMR [#{remaining}] [#{current}] [#{total_0s}]"
    current = turn_right_by(current, remaining)
  else raise "Invalid dir [#{dir}]"
  end

  [current, total_0s]
end

def main
  lines = parse_input(load_input)

  total_0s = 0
  current = 50
  puts current
  lines.reduce(current) do |memo, val|
    new_val, new_0s = new_start(memo, val)
    total_0s += new_0s
    printf "  %-5s %-6s %-5s\n", "[#{memo}]", "[#{val}] ", "[#{new_val}] [#{new_0s}]"
    new_val
  end

  puts "Total [#{total_0s}]"
end

main
