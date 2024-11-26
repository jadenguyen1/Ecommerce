class Admin::GenresController < Admin::DashboardController
  def index
    @genres = Genre.all
  end

  def new
    @genre = Genre.new
  end

  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      redirect_to admin_genres_path, notice: "Genre successfully created."
    else
      render :new
    end
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def update
    if @genre.update(genre_params)
      redirect_to admin_genres_path, notice: "Genre successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @genre = Genre.find(params[:id])
    if @genre.destroy
      redirect_to admin_genres_path, notice: "Genre successfully deleted."
    else
      redirect_to admin_genres_path, alert: "Unable to delete the genre."
    end
  end

  private

  def genre_params
    params.require(:genre).permit(:name)
  end
end
