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

  @today_book = @books.where(created_at: Time.zone.now.all_day).count
  @yesterday_book = @books.where(created_at: 1.day.ago.all_day).count

  @this_week_book = @books.where(created_at: 6.days.ago.beginning_of_day..Time.zone.now.end_of_day).count
  @last_week_book = @books.where(created_at: 13.days.ago.beginning_of_day..7.days.ago.end_of_day).count
  @books_6_days_ago = @books.where(created_at: 6.days.ago.all_day).count
@books_5_days_ago = @books.where(created_at: 5.days.ago.all_day).count
@books_4_days_ago = @books.where(created_at: 4.days.ago.all_day).count
@books_3_days_ago = @books.where(created_at: 3.days.ago.all_day).count
@books_2_days_ago = @books.where(created_at: 2.days.ago.all_day).count
@books_1_day_ago  = @books.where(created_at: 1.day.ago.all_day).count
@books_today      = @books.where(created_at: Time.zone.now.all_day).count
if params[:date].present?
  @search_book = @books.where(created_at: params[:date].to_date.all_day).count
end
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

  def following
    @user = User.find(params[:id])
  @users = @user.following
end

def followers
   @user = User.find(params[:id])
  @users = @user.followers
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