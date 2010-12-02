class UsersController < ApplicationController
    before_filter :require_no_user, :only => [:new, :create]
    before_filter :require_user, :only => [:show, :edit, :update]
    layout  :define_layout 
    add_breadcrumb "Dashboard",:root_path
    def new
      @user = User.new
    end

    def create
      @user = User.new(params[:user])
      if @user.save
		    I18n.locale = @user.locale
        redirect_back_or_default root_url
      else
        render :action => :new
      end
    end

    def show
      @user = @current_user
      @user_accounts = @current_user.accounts.find(:all)
 	    add_breadcrumb I18n.t('layout.application.settings'), account_path
	  respond_to do |format|
       format.html # show.html.erb
	  end
    end

    def edit
      @user = @current_user
     add_breadcrumb I18n.t('layout.application.settings'), account_path
     add_breadcrumb I18n.t('layout.application.edit'), edit_account_path
    end

    def update
      @user = @current_user # makes our views "cleaner" and more consistent
      if @user.update_attributes(params[:user])
		    I18n.locale = @user.locale
        flash[:notice] = I18n.t('layout.users.notice_message')  
        redirect_to root_url
      else
        render :action => :edit
      end
    end
    
    private
    def define_layout
        current_user.nil? ? "loggedout_layout" : "application"
    end
end
