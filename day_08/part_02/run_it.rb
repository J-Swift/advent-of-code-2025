def load_input
  File.readlines('input.txt').map(&:strip)
  # File.readlines('input_test.txt').map(&:strip)
end

def distance(a, b)
  (a[0] - b[0])**2 + 
  (a[1] - b[1])**2 + 
  (a[2] - b[2])**2
end

def main
  lines = load_input

  points = lines.map { |it| it.split(',').map(&:to_i) }

  distances = points[0..-2].each_with_index.reduce([]) do |memo, (point_a, idx)|
    points[(idx+1)..].each do |point_b|
      res = [[point_a, point_b].sort, distance(point_a, point_b)]
      memo << [[point_a, point_b].sort, distance(point_a, point_b)]
    end
    memo
  end
  distances = distances.sort_by { |_, d| d }

  circuits = points.map { |it| Set.new([it]) }

  current = 0
  while true
    (point_a, point_b), distance = distances[current]

    combined_curcuit = Set.new
    new_circuits = circuits.reduce([]) do |memo, circuit|
      if circuit.member?(point_a) || circuit.member?(point_b)
        combined_curcuit = combined_curcuit.union(circuit)
      else
        memo << circuit
      end

      memo
    end
    new_circuits << combined_curcuit
    circuits = new_circuits

    break if circuits.size == 1
    current += 1
  end

  (point_a, point_b), _ = distances[current]
  puts point_a[0] * point_b[0]
end

main
