load 'model.rb'
load 'chef_tenure.rb'
load 'critic.rb'
load 'restaurant.rb'
load 'restaurant_review.rb'

class Chef < Model

	# attr_accessible :first_name, :last_name, :mentor_id

  def self.table_name
    "chefs"
  end

  attr_accessible :first_name, :last_name, :mentor_id

  def initialize(options)
    @id = options["id"]
    @first_name = options["first_name"]
    @last_name = options["last_name"]
    @mentor_id = options["mentor_id"]
  end

  def proteges
    query = <<-SQL
      SELECT c2.*
      FROM chefs c1 JOIN chefs c2
      ON c1.id = c2.mentor_id
      WHERE c1.id = ?
    SQL

    results = RestaurantsDatabase.instance.execute(query, id)
    results.map{|result| Chef.new(result)}
  end

  def num_proteges
    query = <<-SQL
      SELECT COUNT(c2.id) count
      FROM chefs c1 JOIN chefs c2
      ON c1.id = c2.mentor_id
      WHERE c1.id = ?
      GROUP by c1.id
    SQL

    results = RestaurantsDatabase.instance.execute(query, id)[0]["count"]
  end

  def coworkers
    query = <<-SQL
    SELECT coworker.*
    FROM chefs me
    JOIN chef_tenures ct
    ON me.id = ct.chef_id
    JOIN chef_tenures ct2
    ON ct.restaurant_id = ct2.restaurant_id
    JOIN chefs coworker
    ON coworker.id = ct2.chef_id
    WHERE ((ct2.start_date BETWEEN ct.start_date AND ct.end_date)
      OR (ct.start_date BETWEEN ct2.start_date AND ct2.end_date))
    AND coworker.id <> ?
    AND me.id = ?
    SQL

    results = RestaurantsDatabase.instance.execute(query,id, id)

    results.map{|result| Chef.new(result)}
  end

  def reviews
    query = <<-SQL
    SELECT r.*
    FROM chef_tenures c
    JOIN restaurant_reviews r
    ON c.restaurant_id = r.restaurant_id
    WHERE head_chef = 1 AND (r.review_date BETWEEN c.start_date AND c.end_date)
    AND c.chef_id = ?
    SQL
    results = RestaurantsDatabase.instance.execute(query,id)
    results.map{|result| RestaurantReview.new(result)}
  end

end