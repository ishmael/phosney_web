class AccountsController < ApplicationController
  def index
    @accounts = @current_user.accounts.find_accounts_with_balance(:all)
		@last5movements = @current_user.movements.find(:all,:limit => 5,:order => "movdate desc")
		respond_to do |format|
			format.html # index.html.erb
			format.iphone  { render :layout => false }
		end
  end

end
