class Critic < Model

  def self.table_name
    "critics"
  end

  attr_reader :id

  def initialize(options)
    @id = options["id"]
    @screen_name = options["screen_name"]
  end

  def reviews
    results = RestaurantReview.find_by_critic_id(id)
    results.map{|result| RestaurantReview.new(result)}
  end

  def average_review_score
    query = <<-SQL
      SELECT AVG(r.score) score
      FROM critics c JOIN restaurant_reviews r
      ON c.id = r.critic_id
      WHERE c.id = ?
    SQL
    RestaurantsDatabase.instance.execute(query, id)[0]["score"]
  end

  def unreviewed_restaurants
    query = <<-SQL
      SELECT *
      FROM restaurants
      WHERE id NOT IN
      (SELECT DISTINCT r.restaurant_id
      FROM chefs c
      JOIN restaurant_reviews r
      ON r.critic_id = c.id
      WHERE c.id = 1)
    SQL
  end

end