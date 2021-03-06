# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.
require 'runt'
class ApplicationController < ActionController::Base
  
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  
  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  filter_parameter_logging :password, :password_confirmation
  helper_method :current_user_session, :current_user
  before_filter :set_locale
  before_filter :adjust_format_for_iphone
  before_filter :generate_menu 
  before_filter :addmovement 

   
  
  private
  
    def addmovement
		if  not flash[:quickmovement] and not current_user.nil?
			@quick_movement = Movement.new
			@quick_movement.mov_type = -1
    	@quick_movement.amount = 0
		elsif flash[:quickmovement]
			@quick_movement = flash[:quickmovement]
		end
	end
	
	def generate_menu
		if not current_user.nil?
			@menu_accounts = current_user.accounts.find_accounts(:all)
		end
	end
	
	def set_locale
		if not current_user.nil?
			I18n.locale = @current_user.locale
		else
			xxx = request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
			if xxx.match /^(en|pt)$/
				I18n.locale = xxx
			else
				I18n.locale = 'en'
			end
		end	
	end
  
	def adjust_format_for_iphone
		#if request.env["HTTP_USER_AGENT"] && request.env["HTTP_USER_AGENT"][/(Mobile\/.+Safari)/]
		#	request.format = :iphone
		#end
	end

	def current_user_session
	  return @current_user_session if defined?(@current_user_session)
	  @current_user_session = UserSession.find
	end

	def current_user
	  return @current_user if defined?(@current_user)
	  @current_user = current_user_session && current_user_session.user
	end
			
	def require_user
		 unless current_user
		   store_location
		   flash[:notice] = "You must be logged in to access this page"
		   redirect_to new_user_session_url
		   return false
		 end
	end

	def require_no_user
	 if current_user
	   store_location
	   flash[:notice] = "You must be logged out to access this page"
	   redirect_to dashboard_url
	   return false
	 end
	end

	def store_location
	 session[:return_to] = request.request_uri
	end

	def redirect_back_or_default(default)
	 redirect_to(session[:return_to] || default)
	 session[:return_to] = nil
	end
end
