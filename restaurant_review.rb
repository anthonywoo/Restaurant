class RestaurantReview < Model

  def self.table_name
    "restaurant_reviews"
  end

  def self.find_by_critic_id(id)
    query = <<-SQL
      SELECT r.* 
      FROM critics c JOIN restaurant_reviews r 
      ON c.id = r.critic_id
      WHERE c.id = ?
    SQL

    RestaurantsDatabase.instance.execute(query, id)
  end

  def self.find_by_restaurant_id(id)
    query = <<-SQL
      SELECT rr.* 
      FROM restaurants r JOIN restaurant_reviews rr 
      ON r.id = rr.restaurant_id
      WHERE r.id = ?
    SQL

    RestaurantsDatabase.instance.execute(query, id)
  end

  def initialize(options)
    @id = options["id"]
    @critic_id = options["critic_id"]
    @restaurant_id = options["restaurant_id"]
    @score = options["score"]
    @review_date = options["review_date"]
    @review = options["review"]
  end

end