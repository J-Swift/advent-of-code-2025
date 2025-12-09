def load_input
  File.readlines('input.txt').map { |it| it.gsub(/\n/, '') }
  # File.readlines('input_test.txt').map { |it| it.gsub(/\n/, '') }
  # File.readlines('input_test_2.txt').map { |it| it.gsub(/\n/, '') }
end

def parse_input(lines)
  lines
end

def main
  lines = parse_input(load_input)

  parsed = lines.map { |line| line.reverse }

  num_lines = parsed[0..-2]
  ops = parsed[-1]
  # pp nums
  # pp ops

  was_op = false

  nums = []
  total = 0
  ops.split('').each_with_index do |op, op_idx|
    if was_op
      was_op = false
      next
    end

    num = num_lines.reduce([]) do |memo, line|
      memo << line[op_idx] unless line[op_idx] == ' '
      memo
    end.join('').to_i
    nums << num if num

    if op != ' '
      was_op = true
      total += nums.reduce(op.to_sym)
      nums = []
      next
    end
  end

  puts total
end

main
