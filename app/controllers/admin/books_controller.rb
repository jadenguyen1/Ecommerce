class Admin::BooksController < Admin::DashboardController
  before_action :set_book, only: [:edit, :update, :destroy]

  def index
    @books = Book.all

    # Default sorting direction
    direction = params[:direction] == 'desc' ? 'desc' : 'asc'

    # Handle sorting by title, author, price, or genre
    if params[:sort_by].present?
      case params[:sort_by]
      when 'title'
        @books = @books.order("title #{direction}")
      when 'author'
        @books = @books.joins(:author).order("authors.name #{direction}")
      when 'price'
        @books = @books.order("price #{direction}")
      when 'genre'
        @books = @books.joins(:genre).order("genres.name #{direction}")
      end
    end
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      redirect_to admin_books_path, notice: "Book successfully created."
    else
      render :new
    end
  end

  def edit; end

  def update
    if @book.update(book_params)
      redirect_to admin_books_path, notice: "Book successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    if @book.destroy
      redirect_to admin_books_path, notice: 'Book was successfully deleted.'
    else
      redirect_to admin_books_path, alert: 'Unable to delete the book.'
    end
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:title, :description, :stock, :sale, :price, :author_id, :genre_id)
  end
end
