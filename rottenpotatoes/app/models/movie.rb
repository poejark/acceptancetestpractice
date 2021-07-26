class Movie < ActiveRecord::Base
  def self.filtered_director(director)
    return Movie.where(director: director)
  end
end
