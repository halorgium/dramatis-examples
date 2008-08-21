class Round
  include Dramatis::Actor

  def initialize(name, players)
    actor.refuse :finished?
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
  
  def play
    release(@players[-1]).serve(self)
  end
  
  def failed(loser, volleys)
    @end_time = Time.now
    @loser = loser
    @volleys = volleys
    puts "END: #{@name} in #{@end_time - @start_time} seconds"
    actor.accept :finished?
  end
  
  def finished?
    !!@loser
  end
end
