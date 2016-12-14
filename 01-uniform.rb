r = Random.new(123)

developers = 10
projects   = 100
stages     = 8


links = (stages - 1).times.map do |stage|
  projects.times.map do |project|

    from, to = nil
    until from != to
      from = r.rand(1..developers)
      to = r.rand(1..developers)
    end

    [ from, to, stage ]

  end
end.flatten(1)


puts 'from, to, stage'
links.each do |link|
  puts link.join(',')
end
