class Movie < ActiveRecord::Base
  validates :title, presence: true
  def self.all_ratings
    self.select(:rating).distinct.pluck(:rating)
  end

  def self.find_similar_by_director(director_name)
    # Encontra todos os filmes onde a coluna 'director' é igual ao nome passado
    where(director: director_name)
  end
end