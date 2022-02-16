class BooksController < ApplicationController
  
  # before_action :authenticate_user!, only:[:edit, :destroy]
  
  def create
    @new_book = Book.new(book_params)
    @new_book.user_id = current_user.id
    if @new_book.save
      redirect_to book_path(@new_book.id), notice: "You have created book successfully."
    else
      @books = Book.all
      render :index
    end
  end

  def index
    @new_book = Book.new
    @books = Book.all
    @current_user = current_user
  end

  def show
    @new_book = Book.new
    @book = Book.find(params[:id])
    @books = Book.all
    @user = @book.user
    # @current_user = @book.userから上記に変更した
    # application.html.erbのHomeリンクの記述部分にあるuser_path(current_user.id)のcurrent_userと同じと認識されてしまっていた
  end

  def edit
    @book = Book.find(params[:id])
    unless @book.user == current_user
      redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book.id), notice: "You have updated book successfully."
    else
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

end
