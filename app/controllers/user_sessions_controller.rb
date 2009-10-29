class UserSessionsController < ApplicationController
   before_filter :require_no_user, :only => [:new, :create]
   before_filter :require_user, :only => :destroy
   layout "loggedout_layout", :only => [:new,:create] 

	
	
    def new
      @user_session = UserSession.new
	  
	  respond_to do |format|
		  format.html # new.html.erb
		  format.iphone do  #action.iphone.erb
          render :layout => "application"
		  end
	  end
    end

    def create
      @user_session = UserSession.new(params[:user_session])
      if @user_session.save
        #flash[:notice] = "Login successful!"
        redirect_back_or_default dashboard_url
      else
        render :action => :new
      end
    end

    def destroy
      current_user_session.destroy
      #flash[:notice] = "Logout successful!"
      redirect_back_or_default new_user_session_url
    end
end
