class AuthorsController < ApplicationController
  before_action :set_author, only: %i[ show edit update destroy ]

  # GET /authors or /authors.json
  def index
    @authors = Author.all
  end

  # GET /authors/1 or /authors/1.json
  def show
    @author = Author.find(params[:id])
  end

  # GET /authors/new
  def new
    @author = Author.new
  end

  # GET /authors/1/edit
  def edit
  end

  # POST /authors or /authors.json
  def create
    @author = Author.new(author_params)
    if @author.save
      redirect_to admin_authors_path, notice: "Author successfully created."
    else
      render :new
    end
  end

  # PATCH/PUT /authors/1 or /authors/1.json
  def update
    @author = Author.find(params[:id])
    if @author.update(author_params)
      redirect_to admin_authors_path, notice: "Author successfully updated."
    else
      render :edit
    end
  end

  # DELETE /authors/1 or /authors/1.json
  def destroy
    @author = Author.find(params[:id])
    if @author.destroy
      redirect_to admin_authors_path, notice: "Author successfully deleted."
    else
      redirect_to admin_authors_path, alert: "Unable to delete the author."
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_author
      @author = Author.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def author_params
      params.require(:author).permit(:name)
    end
end
