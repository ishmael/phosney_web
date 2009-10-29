class DashboardController < ApplicationController
	before_filter :require_user #, :only => [:new, :create,:edit,:update,:index,:destroy]
  
  def index
		@bankaccounts = @current_user.bankaccounts.find_accounts_with_balance(:all)
		@last5movements = @current_user.movements.find(:all,:limit => 5,:order => "movdate desc")
		@year_data = Movement.data_by_year(:all, :conditions => ["accounts_users.user_id= :id and  movements.movdate BETWEEN :from  AND :to",{:id => @current_user.id, :from => Time.now.beginning_of_year, :to => Time.now.end_of_year}]  )
		@categories = @current_user.categories.find(:all)
		@tags = @current_user.tags.find(:all)
		respond_to do |format|
			format.html # index.html.erb
			format.iphone  { render :layout => false }
		end
  end

end
