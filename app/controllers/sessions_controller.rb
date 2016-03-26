class SessionsController < ApplicationController
  skip_before_action :authorize
  def new
  end

  def create
  	user = User.find_by(name: params[:name])
  	if user and user.authenticate(params[:password])
  		session[:user_id] = user.user_id
  		redirect_to admin_url
  	else
  		redirect_to login_url, alert: "Невірна комбінація імені та паролю"
  	end
  end

  def destroy
  	  session[:user_id] = nil
  	  redirect_to store_url, notice: "Сеанс роботи завершений"
  end
end
