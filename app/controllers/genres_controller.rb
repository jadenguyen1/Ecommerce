class GenresController < ApplicationController
  before_action :set_genre, only: %i[ show edit update destroy ]

  # GET /genres or /genres.json
  def index
    @genres = Genre.all
  end

  # GET /genres/1 or /genres/1.json
  def show
    @genre = Genre.find(params[:id])
  end

  # GET /genres/new
  def new
    @genre = Genre.new
  end

  # GET /genres/1/edit
  def edit
  end

  # POST /genres or /genres.json
  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      redirect_to admin_genres_path, notice: "Genre successfully created."
    else
      render :new
    end
  end

  # PATCH/PUT /genres/1 or /genres/1.json
  def update
    if @genre.update(genre_params)
      redirect_to admin_genres_path, notice: "Genre successfully updated."
    else
      render :edit
    end
  end

  # DELETE /genres/1 or /genres/1.json
  def destroy
    @genre = Genre.find(params[:id])
    if @genre.destroy
      redirect_to admin_genres_path, notice: "Genre successfully deleted."
    else
      redirect_to admin_genres_path, alert: "Unable to delete the genre."
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_genre
      @genre = Genre.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def genre_params
      params.require(:genre).permit(:name)
    end
end
