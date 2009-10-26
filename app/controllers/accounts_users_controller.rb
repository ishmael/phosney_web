class AccountsUsersController < ApplicationController
  before_filter :require_user 
  
  def edit
	  @account = @current_user.bankaccounts.find_by_id(params[:bankaccount_id])
	  if
		@sharedaccount = @account.accounts_users.find_by_id(params[:id], :select => "accounts_users.*, (select login from users where users.id = accounts_users.user_id) as login")
		if @sharedaccount
			respond_to do |format|
			  format.html 
			  format.iphone  { render :layout => false }
			  format.xml  { render :xml => @sharedaccount }
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
			flash[:notice] = 'Acccounts Users was successfully updated.'
			format.html { redirect_to([@account,:movements]) }
			format.xml  { head :ok }
		  else
			format.html { render :action => "edit" }
			format.xml  { render :xml => @sharedaccount.errors, :status => :unprocessable_entity }
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
