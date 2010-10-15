class AccountsUsersController < ApplicationController
  before_filter :require_user 
  add_breadcrumb "Dashboard",:root_path
    
  def edit
	  @account = @current_user.bankaccounts.find_by_id(params[:bankaccount_id])
	  if @account
		    @sharedaccount = @account.accounts_users.find_by_id(params[:id], :select => "accounts_users.*, (select login from users where users.id = accounts_users.user_id) as login")
		    add_breadcrumb @account.name,polymorphic_path([@account,:movements])
        add_breadcrumb I18n.t('layout.accountsusers.name'),  edit_polymorphic_path([@account,@sharedaccount])
		    if @sharedaccount
			    respond_to do |format|
			      format.html 
			      format.iphone  { render :layout => false }
			    end
		    else
			    redirect_to(dashboard_url)
		    end
	  else
			redirect_to(dashboard_url)
	  end	
  end

  def update
   @account = @current_user.bankaccounts.find_by_id(params[:bankaccount_id])
  @sharedaccount = AccountsUser.find_by_id(params[:id])
	if @sharedaccount
		respond_to do |format|
		  if @sharedaccount.update_attributes(params[:accounts_user])
        flash[:notice] = I18n.t('layout.accountsusers.notice_message')  %   [@sharedaccount.user.login]
			format.html { redirect_to([@account,:movements]) }
		  else
			format.html { render :action => "edit" }
		  end
		end
	else
		redirect_to(dashboard_url)
	end
  end

  def destroy
# @category = @current_user.categories.find_by_id(params[:id])
#	if @category
#		@category.destroy
#
#		respond_to do |format|
#		  format.html { redirect_to(categories_path) }
#		  format.xml  { head :ok }
#		end
#	else
#		redirect_to(categories_path)
#	end
  end

end
