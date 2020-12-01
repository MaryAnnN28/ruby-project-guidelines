class User

  attr_accessor :id, :user_name

  @@all=[]

  def initialize(id=nil, user_name)
    @id=id
    @user_name=user_name
    self.class.all << self.all
  end

  def self.all
    @@all
  end

end
