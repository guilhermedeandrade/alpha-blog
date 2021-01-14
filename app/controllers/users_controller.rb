# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: %i[edit update show destroy]
  before_action :require_user, only: %i[edit update]
  before_action :require_same_user, only: %i[edit update destroy]

  def show
    @articles = @user.articles.paginate(page: params[:page], per_page: 5)
  end

  def index
    @users = User.paginate(page: params[:page], per_page: 5)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Welcome to the Alpha Blog #{@user.username}, you have successfully signed up"
      redirect_to articles_path
    else
      render 'new'
    end
  end

  def update
    if @user.update(user_params)
      flash[:success] = 'Your profile was updated successfully.'
      redirect_to @user
    else
      render 'edit'
    end
  end

  def edit; end

  def destroy
    @user.destroy
    session[:user_id] = nil if @user == current_user
    flash[:success] = 'Account and all associated articles successfully deleted.'
    redirect_to root_path
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def require_same_user
    return if (current_user == @user) || current_user.admin?

    flash[:alert] = 'You can only edit or delete your own account'
    redirect_to @user
  end
end
