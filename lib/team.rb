class Team

  attr_accessor :id, :team_name

  @@all=[]

  def initialize(id=nil, team_name)
    @id=id
    @team_name=team_name
    self.class.all << self.all
  end

  def self.all
    @@all
  end

# Include methods for fetching Team stats here

end
