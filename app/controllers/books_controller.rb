class BooksController < ApplicationController
  before_action :set_book, only: %i[ show edit update destroy ]

  # GET /books or /books.json
  def index
    # Filter for the newest books (latest 10 created)
    if params[:filter] == "newest"
      @books = Book.order(created_at: :desc).limit(10)
    # Filter for books on sale (assuming there's a boolean 'sale' attribute)
    elsif params[:filter] == "sale"
      @books = Book.where(sale: true)
    else
      @books = Book.all
    end

    @books = @books.page(params[:page]).per(15)

  end
  # GET /books/1 or /books/1.json
  def show
    @book = Book.find(params[:id])
  end
  # GET /books/new
  def new
    @book = Book.new
  end

  # GET /books/1/edit
  def edit
  end

  def by_genre
    @genre = Genre.find(params[:id])
    @books = @genre.books
  end

  # POST /books or /books.json
  def create
    @book = Book.new(book_params)
    if @book.save
      redirect_to admin_books_path, notice: "Book successfully created."
    else
      render :new
    end
  end

  # PATCH/PUT /books/1 or /books/1.json
  def update
    if @book.update(book_params)
      redirect_to admin_books_path, notice: "Book successfully updated."
    else
      render :edit
    end
  end

  # DELETE /books/1 or /books/1.json
  def destroy
    @book = Book.find(params[:id])
    if @book.destroy
      redirect_to admin_books_path, notice: 'Book was successfully deleted.'
    else
      redirect_to admin_books_path, alert: 'Unable to delete the book.'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def book_params
      params.require(:book).permit(:title, :description, :stock, :sale, :price, :author_id, :genre_id)
    end
end
