class HomeController < ApplicationController
  
  layout 'application_layout'
  
  def index
    @books = Book.where(:publish_status => true)
  end
  
end
