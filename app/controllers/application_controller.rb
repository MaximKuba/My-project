class ApplicationController < ActionController::Base
	before_action :authorize
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  protected

      def authorize
      	unless User.find_by(id: session[:user_id])
      		redirect_to login_url, notice: "Буль-ласка,пройдіть авторизацію"
      	end
      end
end