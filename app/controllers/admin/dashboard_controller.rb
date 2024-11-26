class Admin::DashboardController < ApplicationController
  before_action :require_admin

  def index
    @books = Book.all
    @genres = Genre.all
    @authors = Author.all
  end

  private

  def require_admin
    unless current_user&.admin?
      redirect_to books_path, alert: "You must be an admin to access this page."
    end
  end
end
