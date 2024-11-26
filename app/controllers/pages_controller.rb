# app/controllers/pages_controller.rb
class PagesController < ApplicationController
  def contact
    @page = Page.find_by(slug: 'contact') # or any other criteria to find the page
  end
end
