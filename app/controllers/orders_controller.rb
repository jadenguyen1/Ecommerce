class OrdersController < ApplicationController
  before_action :authenticate_user, only: [:new, :create] # Redirects non-logged-in users to login page

  def new
    @order = Order.new
    @provinces = Province.all
    @cart_total = calculate_cart_total
    @subtotal = @cart_total || 0 # Sum of all items in the cart before tax.

    # Get cart items from session
    @cart_items = session[:cart] || {}

    if current_user
      @user_address = current_user.address
      @user_province = current_user.province
    end

    # Tax rate based on the user's province
    @tax_rate = @user_province ? @user_province.tax_rate : 0

    # Tax amount
    @tax_amount = (@subtotal * @tax_rate).round(2)

    # Total with taxes
    @total_with_tax = (@subtotal + @tax_amount).round(2)
  end

  def create
    @order = Order.new(order_params)
    @provinces = Province.all
    ActiveRecord::Base.transaction do
      if current_user
        # If the user is logged in, automatically assign the logged-in user to the order
        @order.user = current_user
      else
        # If the user is not logged in, redirect to login page
        redirect_to login_path, alert: "You must be logged in to complete the order." and return
      end

      @cart_total = calculate_cart_total
    @subtotal = @cart_total || 0 # Sum of all items in the cart before tax.

    # Tax rate based on the selected province
    @selected_province = Province.find_by(id: @order.user.province_id)
    @tax_rate = @selected_province ? @selected_province.tax_rate : 0

    # Tax amount
    @tax_amount = (@subtotal * @tax_rate).round(2)

    # Total with taxes
    @total_with_tax = (@subtotal + @tax_amount).round(2)

    @order.total_price = @total_with_tax

      # Save the order with the total price and other details
      @order.order_date = Time.now
      @order.save!

      # Create order items for each item in the cart
      session[:cart]&.each do |book_id, quantity|
        book = Book.find(book_id)
        @order.order_items.create!(book: book, quantity: quantity, unit_price: book.price)
      end

      # Clear the shopping cart after saving the order
      session.delete(:cart)

      # Redirect to the books page or a success page
      redirect_to books_path, notice: "Order completed successfully!"
    end
  rescue ActiveRecord::RecordInvalid => e
    render :new, alert: "An error occurred. Please try again."
  end

  def show
    @order = Order.find(params[:id])
    # You can also load associated order items if needed
    @order_items = @order.order_items
  end


  private

  def authenticate_user
    redirect_to login_path, alert: "You must be logged in to complete the order." unless current_user
  end

  def calculate_cart_total
    subtotal = session[:cart]&.sum do |book_id, quantity|
      book = Book.find(book_id)
      book.price * quantity
    end || 0
  end

  def order_params
    # This will permit user_id if the user is logged in.
    params.require(:order).permit(:total_price, order_items_attributes: [:book_id, :quantity, :unit_price])
  end
end
