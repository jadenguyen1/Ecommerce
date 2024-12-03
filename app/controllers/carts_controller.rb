class CartsController < ApplicationController
  before_action :set_cart

  def add_to_cart
    book = Book.find(params[:book_id])
    session[:cart] ||= {}

    if session[:cart][book.id.to_s]
      session[:cart][book.id.to_s] += 1 # Increase quantity if the item already exists in the cart
    else
      session[:cart][book.id.to_s] = 1 # Add new item to the cart
    end

    redirect_to books_path, notice: "#{book.title} has been added to your cart."
  end

  def show
    @cart_items = []
    @total_price = 0

    session[:cart]&.each do |book_id, quantity|
      book = Book.find(book_id)
      @cart_items << { book: book, quantity: quantity, total_price: book.price * quantity }
      @total_price += book.price * quantity
    end
  end

  def remove_from_cart
    book = Book.find(params[:book_id])
    session[:cart].delete(book.id.to_s)
    redirect_to cart_path, notice: "#{book.title} has been removed from your cart."
  end

  def update_quantity
    book = Book.find(params[:book_id])
    session[:cart][book.id.to_s] = params[:quantity].to_i
    redirect_to cart_path, notice: "#{book.title} quantity has been updated."
  end

  private

  def set_cart
    session[:cart] ||= {}
  end
end
