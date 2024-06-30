class UsersController < ApplicationController
  before_action :is_signed_in
  before_action :is_matching_login_user, only:[:edit, :update]


  def index
    @user = User.find(current_user.id)
    @book = Book.new
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @book = Book.new
    @books = @user.books
  end

  def create
    @user = User.new(user_params)
    @user.save
    redirect_to root_path
  end


  def edit
    if user_signed_in?
      @user = User.find(current_user.id)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

  def is_matching_login_user
    user = User.find(params[:id])
      unless user.id == current_user.id
        redirect_to user_path(current_user.id)
      end
  end

  def is_signed_in
    unless user_signed_in?
      redirect_to new_user_session_path
    end
  end

end
