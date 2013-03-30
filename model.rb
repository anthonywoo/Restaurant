load 'restaurants_database.rb'

class Model

  def self.table_name
    raise NotImplementedError
  end

  def self.all
    results = RestaurantsDatabase.instance.execute("SELECT * FROM #{self.table_name}")
    results.map{|result| self.new(result)}
  end

  def self.find(id)
   result = RestaurantsDatabase.instance.execute("SELECT * FROM #{self.table_name} WHERE id = #{id}")
   raise "No Entry Found in DB" if result.empty?
   self.new(result[0])
  end

	def self.column_names
		@columns
	end

	def id
		self.instance_variable_get "@id"
	end

	def build_update_query
		str = "UPDATE #{self.class.table_name} SET"
		self.class.column_names.each do |name|
			val = self.send(name)
			str += ", #{name}='#{val}'"
		end
		str.gsub!("SET,", "SET")
		str += " WHERE id=#{self.id}"
	end

	def build_insert_query
		str = "INSERT INTO #{self.class.table_name} "
		cols = "("
		values = "("
		self.class.column_names.each do |name|
			val = self.send(name)
			cols += ",#{name}"
			values += ",'#{val}'"
		end
		cols = cols.gsub("(,", "(").concat(") ")
		values = values.gsub("(,", "(").concat(") ")
		str = str + cols + "VALUES " + values + ";"
	end

  def save
    if @id
      query = build_update_query
      RestaurantsDatabase.instance.execute(query)
    else
      query = build_insert_query
      RestaurantsDatabase.instance.execute(query)
      @id = RestaurantsDatabase.instance.last_insert_row_id
    end
  end

  protected

  def self.attr_accessible(*column_names)

		self.instance_variable_set("@columns", column_names)
    column_names.each do |column|
      self.send(:define_method, column){self.instance_variable_get "@#{column}"}
      self.send(:define_method, "#{column.to_s}=".to_sym){|x|
      	self.instance_variable_set("@#{column}", x)
      }
    end
  end

end