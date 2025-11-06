require 'rails_helper'

describe MoviesController, type: :controller do

  describe "PUT #update" do
    before :each do
      @movie = Movie.create(title: "Filme Teste", director: "Diretor Antigo")
    end

    it "atualiza o diretor do filme" do
      # Simula o envio do formulário com o novo diretor
      put :update, params: { id: @movie.id, movie: { director: "Novo Diretor" } }

      # Recarrega o filme do banco de dados para ver se mudou
      @movie.reload

      # Verifica se o diretor foi realmente atualizado
      expect(@movie.director).to eq("Novo Diretor")
    end
    context "com parâmetros inválidos" do
      before :each do
        # Cria um filme para ser atualizado
        @movie = Movie.create(title: "Filme Original", director: "Diretor Original")
      end

      it "não atualiza o filme" do
        # Tenta atualizar o filme com um título em branco
        put :update, params: { id: @movie.id, movie: { title: "" } }
        @movie.reload

        # Espera que o título não tenha mudado
        expect(@movie.title).to eq("Filme Original")
      end

      it "renderiza novamente o template 'edit'" do
        put :update, params: { id: @movie.id, movie: { title: "" } }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe "GET #search_director" do
    context "quando o filme tem um diretor" do
      before :each do
        # Cria um filme falso com diretor
        @movie = double('Movie', id: '1', title: 'Star Wars', director: 'George Lucas')
        allow(Movie).to receive(:find).with('1').and_return(@movie)
      end

      it "chama o método do model para encontrar filmes similares" do
        # Espera que o Model Movie receba a chamada
        expect(Movie).to receive(:find_similar_by_director).with('George Lucas')

        get :search_director, params: { id: '1' }
      end
    end

    context "quando o filme NÃO tem um diretor" do
      before :each do
        # Cria um filme falso sem diretor
        @movie_no_director = double('Movie', id: '2', title: 'Alien', director: nil)
        allow(Movie).to receive(:find).with('2').and_return(@movie_no_director)
      end

      it "redireciona para a página inicial" do
        get :search_director, params: { id: '2' }
        expect(response).to redirect_to(movies_path)
      end

      it "define uma mensagem de flash (aviso)" do
        get :search_director, params: { id: '2' }
        expect(flash[:notice]).to be_present
      end
    end
  end

  describe "GET #new" do
    it "renderiza o template 'new'" do
      get :new
      expect(response).to render_template(:new)
    end
  end
  
  describe "POST #create" do
    
    # Define os atributos válidos para um novo filme
    let(:atributos_validos) do
      { title: 'Filme de Teste', rating: 'PG', release_date: '2025-01-01', director: 'Diretor de Teste' }
    end

    # Define atributos inválidos
    let(:atributos_invalidos) do
      { title: '', rating: 'PG', release_date: '2025-01-01' }
    end

    context "com parâmetros válidos" do
      it "cria um novo filme no banco de dados" do
        # Espera que o código dentro do bloco mude a contagem de Movie em +1
        expect {
          post :create, params: { movie: atributos_validos }
        }.to change(Movie, :count).by(1)
      end

      it "redireciona para a página de detalhes do novo filme" do
        post :create, params: { movie: atributos_validos }
        expect(response).to redirect_to(movie_path(Movie.last))
      end
    end

    context "com parâmetros inválidos" do
      it "não cria um novo filme no banco de dados" do
        # Espera que o código não mude a contagem de Movie
        expect {
          post :create, params: { movie: atributos_invalidos }
        }.not_to change(Movie, :count)
      end

      it "renderiza novamente o template 'new'" do
        post :create, params: { movie: atributos_invalidos }
        expect(response).to render_template(:new)
      end
    end
  end

  describe "DELETE #destroy" do
    
    # Cria um filme que possamos deletar antes do teste rodar
    before :each do
      @movie_to_delete = Movie.create(title: 'Filme para Deletar', rating: 'G')
    end

    it "deleta o filme do banco de dados" do
      # Espera que o código mude a contagem de Movie em -1
      expect {
        delete :destroy, params: { id: @movie_to_delete.id }
      }.to change(Movie, :count).by(-1)
    end

    it "redireciona para a página principal (index)" do
      delete :destroy, params: { id: @movie_to_delete.id }
      expect(response).to redirect_to(movies_path)
    end
  end

  describe "GET #index" do
    before :each do
      # Cria filmes com ratings diferentes para o teste
      @movie_pg = Movie.create(title: 'Filme PG', rating: 'PG')
      @movie_r = Movie.create(title: 'Filme R', rating: 'R')
    end

    context "quando nenhum filtro de rating é aplicado" do
      it "mostra todos os filmes" do
        get :index
        expect(assigns(:movies)).to include(@movie_pg, @movie_r)
      end
    end

    context "quando um filtro de rating é aplicado" do
      it "mostra apenas os filmes com o rating selecionado" do
        # Simula o envio do formulário com 'PG' marcado
        get :index, params: { ratings: { 'PG' => '1' } }

        expect(assigns(:movies)).to include(@movie_pg)
        expect(assigns(:movies)).not_to include(@movie_r)
      end

      it "define corretamente os @ratings_para_mostrar" do
        get :index, params: { ratings: { 'PG' => '1' } }
        expect(assigns(:ratings_para_mostrar)).to eq(['PG'])
      end
    end
  end
end