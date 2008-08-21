class Round
  include Dramatis::Actor

  attr_reader :name
  def initialize(name, players)
    actor.refuse :runtime
    @start_time = Time.now
    @name = name
    @players = players
    puts "START: #{@name} with #{@players.size} players"
    @players.each do |player|
      player.join(self, @name)
      @players.each do |opponent|
        next if opponent == player
        player.add(self, opponent)
      end
    end
  end

  def play(manager)
    @manager = manager
    release(@players[-1]).serve(self)
  end

  def failed(loser, volleys)
    @end_time = Time.now
    @loser = loser
    @volleys = volleys
    actor.accept :runtime
    release(@manager).complete(self)
  end

  def runtime
    @end_time - @start_time
  end
end
