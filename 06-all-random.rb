r = Random.new(123)

projects       = 200
stages         = 4
developers     = 5
specialization = 1


devs = stages.times.map do |stage|
  specializers = r.rand(1..developers-1)
  (0..(developers-1)).to_a
    .shuffle(random: r)
    .take(specializers)
end

#puts devs.inspect
#exit

links = (stages - 1).times.map do |stage|
  projects.times.map do |project|

    froms = (0..developers-1).to_a
    tos = (0..developers-1).to_a

    # specialize?
    if specialization >= r.rand
      _froms = devs[stage].dup
      _tos   = devs[stage + 1].dup

      # no non-self-referencing links possible if [x] == [x]
      unless (_froms.length <= 1 && _tos.length <= 1 && _froms == _tos)
        froms = _froms
        tos = _tos
      end
    end

    # pick at random
    from, to = nil
    until from != to
      from = froms.shuffle(random: r).first
      to   = tos.shuffle(random: r).first
    end

    [from, to, stage]
  end
end.flatten(1)


puts 'from, to, stage'
links.each do |link|
  puts link.join(',')
end
