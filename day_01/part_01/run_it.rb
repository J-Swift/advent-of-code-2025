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

def new_start(current, command)
  parsed = parse_command(command)

  case parsed[:dir]
  when 'L'
    current -= parsed[:amount]
    while current < 0
      current += 100
    end
  when 'R'
    current += parsed[:amount]
    while current > 99 
      current -= 100
    end
  else raise "Invalid dir [#{parsed[:dir]}]"
  end

  current
end

def main
  lines = parse_input(load_input)

  total_0s = 0
  current = 50
  lines.reduce(current) do |memo, val|
    new_val = new_start(memo, val)
    total_0s += 1 if new_val == 0
    printf "%-5s %-6s %-5s\n", "[#{memo}]", "[#{val}] ", "[#{new_val}]"
    new_val
  end

  puts "Total [#{total_0s}]"
end

main
