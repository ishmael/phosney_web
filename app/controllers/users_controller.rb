class UsersController < ApplicationController
    before_filter :require_no_user, :only => [:new, :create]
    before_filter :require_user, :only => [:show, :edit, :update]
    layout  :define_layout 
    
    def new
      @user = User.new
    end

    def create
      @user = User.new(params[:user])
      if @user.save
		I18n.locale = @user.locale
        flash[:notice] = "Account registered!"
        redirect_back_or_default account_url
      else
        render :action => :new
      end
    end

    def show
      @user = @current_user
	  
	  respond_to do |format|
       format.html # show.html.erb
       format.xml  { render :xml => @user }
	  end
    end

    def edit
      @user = @current_user
    end

    def update
      @user = @current_user # makes our views "cleaner" and more consistent
      if @user.update_attributes(params[:user])
		I18n.locale = @user.locale
        flash[:notice] = "Account updated!"
        redirect_to account_url
      else
        render :action => :edit
      end
    end
    
    private
    def define_layout
        current_user.nil? ? "loggedout_layout" : "application"
    end
end
