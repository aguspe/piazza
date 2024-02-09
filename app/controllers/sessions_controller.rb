class SessionsController < ApplicationController
  def new
  end

  def create
    @app_session = User.create_app_session(email: login_params[:email], password: login_params[:password])
    if @app_session
      flash[:success] = t(".success")
      redirect_to root_path
    else
      flash.now[:alert] = "Invalid email or password"
      render :new
    end
  end

  private

  def login_params
    @login_params ||= params.require(:user).permit(:email, :password)
  end
end
