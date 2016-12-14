r = Random.new(123)

projects = 200
stages = 8
specializers = 3
specialization = 1

nodes = stages * specializers - 1

devs =
  (0..(stages * specializers - 1))
  .each_slice(specializers)
  .map { |s| s }

links = (stages - 1).times.map do |stage|
  projects.times.map do |project|

    from, to = nil
    if specialization >= r.rand
      until from != to
        from = devs[stage][r.rand(0..(specializers-1))]
        to   = devs[stage + 1][r.rand(0..(specializers-1))]
      end
    else
      until from != to
        from = r.rand(0..nodes)
        to   = r.rand(0..nodes)
      end
    end

    [from, to, stage]
  end
end.flatten(1)

puts 'from,to,stage'
links.each do |link|
  puts link.join(',')
end
