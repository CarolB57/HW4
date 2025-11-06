class MoviesController < ApplicationController
  def index
    # Pega o parâmetro de ordenação
    @coluna_ordenada = params[:sort]

    # Checa-se se params[:ratings] existe. Se existir, permite e converte para um hash normal. Se não, usa um hash vazio
    @ratings_selecionados = params[:ratings] ? params[:ratings].permit(Movie.all_ratings).to_h : {}

    # Variável para a View saber todos os ratings que existem
    @all_ratings = Movie.all_ratings

    # Define a lista de ratings a serem mostrados
    if @ratings_selecionados.empty?
      @ratings_para_mostrar = Movie.all_ratings
    else
      @ratings_para_mostrar = @ratings_selecionados.keys
    end

    # Busca os filmes no banco, aplicando filtro e ordenação
    @movies = Movie.where(rating: @ratings_para_mostrar).order(@coluna_ordenada)
  end

  def show
    id = params[:id] # recupera o ID do filme da rota da URI
    @movie = Movie.find(id) # busca o filme pelo ID único
  end

  def search_director
    # Encontra o filme atual pelo ID vindo da rota
    @movie = Movie.find(params[:id])

    if @movie.director.blank?
      flash[:notice] = "'#{@movie.title}' has no director info."
      redirect_to movies_path

    else
      # Chama o método do model
      @movies = Movie.find_similar_by_director(@movie.director)
    end
  end
  def new
    @movie = Movie.new
  end
  def create
    @movie = Movie.new(movie_params)
    
    if @movie.save
      flash[:notice] = "#{@movie.title} foi criado com sucesso."
      redirect_to movie_path(@movie)
    else
      # Se falhar, mostra o formulário 'new' novamente
      render 'new'
    end
  end
  def edit
    @movie = Movie.find(params[:id])
  end
  def update
    @movie = Movie.find(params[:id])
    
    if @movie.update(movie_params)
      flash[:notice] = "#{@movie.title} foi atualizado com sucesso."
      redirect_to movie_path(@movie)
    else
      # Se a atualização falhar, renderiza a página de edição novamente
      render 'edit'
    end
  end
  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    
    flash[:notice] = "Filme '#{@movie.title}' deletado."
    redirect_to movies_path
  end
  private
  def movie_params
    # Adiciona :director a esta lista
    params.require(:movie).permit(:title, :rating, :release_date, :description, :director)
  end
end