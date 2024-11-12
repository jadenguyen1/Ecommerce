json.extract! book, :id, :title, :description, :stock, :sale, :price, :author_id, :genre_id, :created_at, :updated_at
json.url book_url(book, format: :json)
