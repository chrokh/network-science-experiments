r = Random.new(123)

projects       = 100
stages         = 5
devs_per_stage = 2
specialization = 1

nodes = stages * devs_per_stage - 1

devs =
  (0..(stages * devs_per_stage - 1))
  .to_a
  .shuffle(random: r)
  .each_slice(devs_per_stage)
  .map { |s| s }

links = (stages - 1).times.map do |stage|
  projects.times.map do |project|

    from, to = nil
    if specialization >= r.rand
      until from != to
        from = devs[stage][r.rand(0..(devs_per_stage-1))]
        to   = devs[stage + 1][r.rand(0..(devs_per_stage-1))]
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
