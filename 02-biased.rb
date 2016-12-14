r = Random.new(123)

projects         = 100
developers       = 8
stages           = 5
bias_probability = 1
bias_threshold   = 0.3


links = (stages - 1).times.map do |stage|
  projects.times.map do |project|

    from, to = nil
    until from != to
      if r.rand <= bias_probability
        threshold = (developers * bias_threshold).to_i
      else
        threshold = developers
      end
      from = r.rand(0..threshold)
      #
      # TODO: This seems wrong.
      # Shouldn't from also be based on the threshold?
      if r.rand <= bias_probability
        threshold = (developers * bias_threshold).to_i
      else
        threshold = developers
      end
      to = r.rand(0..threshold)
    end

    [
      from, to, stage
    ]

  end
end.flatten(1)


puts 'from, to, stage'
links.each do |link|
  puts link.join(',')
end
