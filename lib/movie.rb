class Movie
  attr_accessor(:score)
  attr_reader(:title,:critic_score)

  def initialize(title)
    @title = title
    @critic_score = nil
  end
end
