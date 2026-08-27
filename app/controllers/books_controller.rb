class BooksController < ApplicationController
  
  before_action :ensure_correct_book, only: [:edit, :update, :destroy]
  def index
    @books = Book.all
    @book = Book.new
  end

  def create
  @book = Book.new(book_params)
  @book.user = Current.user
  if @book.save
    flash[:notice] = "Book was successfully created."
    redirect_to book_path(@book)
  else
    @books = Book.all
    render :index, status: :unprocessable_entity
  end
end

  def show
  @book = Book.find(params[:id])
  @book_comment = BookComment.new
end

  
def edit
  @book = Book.find(params[:id])
end

def update
  @book = Book.find(params[:id])

  if  @book.update(book_params)
  flash[:notice] = "Book was successfully updated."
  redirect_to book_path(@book)
else
  render :edit, status: :unprocessable_entity
end
  
end

def destroy
  book = Book.find(params[:id])
  book.destroy
  redirect_to books_path
end
private
def ensure_correct_book
  @book = Book.find(params[:id])

  unless @book.user == Current.user
    redirect_to books_path
  end
end

def book_params
  params.require(:book).permit(:title, :body)

end

end
