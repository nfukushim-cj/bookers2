class BooksController < ApplicationController
  before_action :is_signed_in
  before_action :is_matching_login_user, only:[:edit, :update]

  def index
    @user = User.find(current_user.id)
    @book = Book.new
    @books = Book.all
  end

  def show
    @books = Book.find(params[:id])
    @book = Book.new
    @user = User.find(@books.user_id)
  end

  def create
    @book = Book.new(book_params)
    @book.user_id=current_user.id
    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book.id)
    else
      @user = User.find(current_user.id)
      @books = Book.all
      render :index
    end

  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end

  private

  def book_params
    params.require(:book).permit(:title, :body, :user_id)
  end

  private

  def is_signed_in
    unless user_signed_in?
      redirect_to new_user_session_path
    end
  end

  def is_matching_login_user
    book = Book.find(params[:id])
      unless book.user_id == current_user.id
        redirect_to books_path
      end
  end

end

