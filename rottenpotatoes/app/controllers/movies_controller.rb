class MoviesController < ApplicationController

  def show
    if params[:id] == "director"
      @movie = Movie.find(1)
    else
      id = params[:id] # retrieve movie ID from URI route
      @movie = Movie.find(id) # look up movie by unique ID
      # will render app/views/movies/show.<extension> by default
    end
  end

  def index
    if !params[:director_DNE].nil?
      @movie = Movie.find params[:id]
      flash[:notice] = "'#{@movie.title}' has no director info"
      @movies = Movie.all
    elsif params[:director_filter].nil?
      @movies = Movie.all
    else
      @movies = Movie.filtered_director(params[:director_filter])
    end
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end
  
  def director
    
    director = params[:director]
    @movie = Movie.find params[:id]
    if director != "dne"
      
      redirect_to movies_path(:director_filter => director)
    else 
      redirect_to movies_path(:id => @movie, :director_DNE => "1")
    end
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

  private
  # Making "internal" methods private is not required, but is a common practice.
  # This helps make clear which methods respond to requests, and which ones do not.
  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date, :director)
  end
end
