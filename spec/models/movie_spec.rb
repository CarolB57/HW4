require 'rails_helper'

describe Movie do
  describe ".find_similar_by_director" do
    
    # Criar alguns filmes de teste no banco de dados ANTES de cada teste
    before :each do
      @movie1 = Movie.create!(title: 'Star Wars', director: 'George Lucas')
      @movie2 = Movie.create!(title: 'THX 1138', director: 'George Lucas')
      @movie3 = Movie.create!(title: 'Blade Runner', director: 'Ridley Scott')
    end

    it "deve encontrar filmes do mesmo diretor" do
      results = Movie.find_similar_by_director('George Lucas')
      
      # Espera que os resultados incluam os filmes corretos
      expect(results).to include(@movie1)
      expect(results).to include(@movie2)
    end

    it "não deve encontrar filmes de diretores diferentes" do
      results = Movie.find_similar_by_director('George Lucas')
      
      # Espera que os resultados não incluam o filme do outro diretor
      expect(results).not_to include(@movie3)
    end
  end
end