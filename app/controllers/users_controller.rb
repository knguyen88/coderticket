class UsersController < ApplicationController

  skip_before_action :require_login, only: [:show_login_form, :do_login, :show_register_form, :do_create_user]

  before_action :skip_login, only: [:show_login_form, :show_register_form]

  def show_login_form
    render 'users/login', layout: 'no_header'
  end

  def do_login
    @user = User.find_by_email(params[:email]).try(:authenticate, params[:password])
    if !!@user
      store_id_and_redirect_to_home(@user)
    else
      flash[:error] = 'Invalid email or password'
      redirect_to login_path
    end
  end

  def show_register_form
    @user = User.new
    render 'users/register', layout: 'no_header'
  end

  def do_create_user
    @user = User.new(user_params)
    if @user.valid?
      @user.save
      store_id_and_redirect_to_home(@user)
    else
      render 'users/register', layout: 'no_header'
    end
  end

  def do_logout
    reset_session
    redirect_to login_path
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def store_id_and_redirect_to_home(user)
    session[:user_id] = user.id
    redirect_to root_path
  end
end
