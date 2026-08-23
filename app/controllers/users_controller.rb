class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:edit, :update]
  allow_unauthenticated_access only: [:new, :create]
  def index
  @users = User.all
  @user = Current.user
  @book = Book.new
end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      start_new_session_for @user
      flash[:notice] = "User was successfully created."
      redirect_to user_path(@user)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      flash[:notice] = "User was successfully updated."
      redirect_to user_path(@user)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private
  def ensure_correct_user
  @user = User.find(params[:id])
  unless @user == Current.user
    redirect_to user_path(Current.user)
  end
end

  def user_params
    params.require(:user).permit(
      :name,
      :email_address,
      :password,
      :password_confirmation,
      :profile_image,
      :introduction
    )
  end
end