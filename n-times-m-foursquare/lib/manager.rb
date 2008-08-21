class Manager
  include Dramatis::Actor

  def initialize(rounds_count, players)
    @rounds = []
    rounds_count.times do |i|
      set = Set.new
      (rand(30).to_i + 5).times do
        set << players[rand(players.size)]
      end
      push(Round.new("round-#{i}", set.to_a))
    end
  end

  def push(round)
    @rounds << round
    release(round).play(self)
  end

  def complete(round)
    puts "END: #{round.name} in #{round.runtime} seconds"
    @rounds.delete(round)
  end
end
