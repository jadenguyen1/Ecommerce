class Admin::AuthorsController < Admin::DashboardController
  def index
    @authors = Author.all
  end

  def edit
    @author = Author.find(params[:id])
  end

  def update
    @author = Author.find(params[:id])
    if @author.update(author_params)
      redirect_to admin_authors_path, notice: "Author successfully updated."
    else
      render :edit
    end
  end

  def new
    @author = Author.new
  end

  def create
    @author = Author.new(author_params)
    if @author.save
      redirect_to admin_authors_path, notice: 'Author successfully created.'
    else
      render :new
    end
  end

  def destroy
    @author = Author.find(params[:id])
    if @author.destroy
      redirect_to admin_authors_path, notice: "Author successfully deleted."
    else
      redirect_to admin_authors_path, alert: "Unable to delete the author."
    end
  end

  private

  def author_params
    params.require(:author).permit(:name)
  end

end
