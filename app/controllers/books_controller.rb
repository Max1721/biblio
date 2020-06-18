class BooksController < ApplicationController
  def index
    @books = Book.all
  end

  def show
    @book = Book.find(params[:id])
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.lender = current_user
    if @book.save
      redirect_to book_path(@book)
    else
      render :new
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
  end

  def destroy
  end

  private

  def book_params

    params.require(:book).permit(:title, :author, :rating, :category, :cover_url, :address, :description)

  end
end


