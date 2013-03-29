require 'singleton'
require 'sqlite3'

class RestaurantsDatabase < SQLite3::Database
  include Singleton

  def initialize
    super("test.db")

    self.results_as_hash = true
    self.type_translation = true
  end

  def self.execute(*args)
    self.instance.execute(*args)
  end
end