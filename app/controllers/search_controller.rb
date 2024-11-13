class SearchController < ApplicationController
  def index
    @genres = Genre.all
    query = params[:query]&.downcase
    genre_id = params[:genre_id]

    @books = Book.joins(:author, :genre)
                 .where("LOWER(books.title) LIKE ? OR LOWER(books.description) LIKE ? OR LOWER(authors.name) LIKE ?",
                        "%#{query}%", "%#{query}%", "%#{query}%")
                 .distinct

    # Filter by genre if a genre is selected
    @books = @books.where(genre_id: genre_id) if genre_id.present?
  end
end
