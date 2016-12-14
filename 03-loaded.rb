r = Random.new(123)

projects       = 30
stages         = 8
specialization = 0.8

links = (stages - 1).times.map do |stage|
  projects.times.map do |project|

    if specialization >= r.rand
      from = stage
      to   = stage + 1
    else
      until from != to
        from = r.rand(0..stages-1)
        to   = r.rand(0..stages-1)
      end
    end

    [
      from, to, stage
    ]

  end
end.flatten(1)

puts 'from,to,stage'
links.each do |link|
  puts link.join(',')
end
