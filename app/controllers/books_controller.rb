class BooksController < ApplicationController
  
  layout 'application_layout'
  
  before_action :authenticate_user!, except: [:show]
  before_action :find_book, only: [:edit,:update,:show,:destroy,:publish_book]
  
  def index
    @books = current_user.books.order(:publish_status)
  end
  
  def new
    @book = Book.new
  end
  
  def create
    @book = Book.new(books_params.merge(:user_id => current_user.id))
    if @book.save
      flash[:success] = "Successfully Created Book"
      redirect_to books_path
    else
      flash[:error] = @book.errors.full_messages.uniq.join(', ')
      render :new
    end
  end
  
  def edit
  end
  
  def update
    book = @book.update_attributes(books_params)
    if book
      flash[:success] = "Successfully Updated Book"
      redirect_to books_path
    else
      flash[:error] = @book.errors.full_messages.uniq.join(', ')
      render :edit
    end
    
  end
  
  def show
  end
  
  def destroy
    delete_book = @book.delete
    flash[:success] = "Successfully Deleted Book" if delete_book
    flash[:error] = @book.errors.full_messages.uniq.join(', ') if !delete_book
    redirect_to books_path
  end
  
  def publish_book
    @book.update_attribute(:publish_status, params[:status])
  end
  
  def sort_books
    params[:sort_order] = (params[:sort_order] == "asc") ? "desc" : "asc"
    @books = current_user.books.order(params[:sort_obj].to_sym params[:sort_order].to_sym)
  end
  
  private
  
  def books_params
    params.require(:book).permit(:book_name,:book_cover,:author,:isbn,:price,:category,:publish_status)
  end
  
  def find_book
    @book = Book.find_by_id(params[:id])
  end
  
end
