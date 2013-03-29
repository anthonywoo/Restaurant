load 'model.rb'
class Restaurant < Model

  def self.table_name
    "restaurants"
  end

  def self.by_neighborhood

  end

  attr_reader :id

  def initialize(options)
    @id = options["id"]
    @name = options["name"]
    @neighborhood = options["neighborhood"]
    @cuisine = options["cuisine"]
  end

  def reviews
    results = RestaurantReview.find_by_restaurant_id(id)
    results.map{|result| RestaurantReview.new(result)}
  end

  def average_review_score
    query = <<-SQL
      SELECT AVG(rr.score) score
      FROM restaurants r JOIN restaurant_reviews rr 
      ON r.id = rr.restaurant_id
      WHERE r.id = ?
    SQL
    RestaurantsDatabase.instance.execute(query, id)[0]["score"]
  end

end