load 'restaurants_database.rb'
require 'pry'
class Model

  def self.table_name
    raise NotImplementedError
  end

  def self.column_names

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

  protected

  def self.attr_accessible(*column_names)
    blk = Proc.new {puts column_names}

    blk2 = Proc.new {|val| self.column = val}

    column_names.each do |column|
      self.send(:define_method, column, &blk)
      self.send(:define_method, "#{column.to_s}=".to_sym, &blk)
    end
  end
end