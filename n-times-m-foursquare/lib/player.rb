class Player
  include Dramatis::Actor

  attr_reader :name
  def initialize(name)
    @name = name
    @rounds = []
    @round_names = []
    @opponents = []
  end

  def join(round, round_name)
    @rounds << round
    @round_names << round_name
    @opponents << []
  end
  
  def add(round, opponent)
    opponents_for(round) << opponent
  end

  def serve(round)
    # We ignore the possiblity
    # of service faults
    opponent = choose_for(round)
    release(opponent).volley(round, 1)
  end

  def volley(round, volleys)
    # We ignore serve do-overs
    # We ignore out of bound hits
    if made_save
      # we ignore bad hits
      opponent = choose_for(round)
      release(opponent).volley(round, volleys + 1)
    else
      round.failed(self, volleys)
    end
  end

private
  def made_save
    rand < 0.99999
  end
  
  def index_for(round)
    @rounds.index(round)
  end
  
  def round_name_for(round)
    @round_names[index_for(round)]
  end
  
  def opponents_for(round)
    @opponents[index_for(round)]
  end
  
  def choose_for(round)
    o = opponents_for(round)
    o[rand(o.size)]
  end
end
