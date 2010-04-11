class ChartsController < ApplicationController
  	before_filter :require_user
  	
  	def expenditure_by_year
  	 	@year_data = Movement.data_by_year(:all, :conditions => ["accounts_users.user_id= :id and  movements.movdate BETWEEN :from  AND :to and accounts.currency = :currency",{:id => @current_user.id, :from => Time.now.beginning_of_year, :to => Time.now.end_of_year,:currency =>params[:currency]}]  )

  		respond_to do |format|	
  			format.xml  { render :action => "income_expenditure_by_year.builder", :layout => false }
  		end
	  end
	  
	  def expenditure_by_month
  	 	@month_data = Movement.data_by_month(:all, :conditions => ["accounts_users.user_id= :id and  movements.movdate BETWEEN :from  AND :to and accounts.currency = :currency",{:id => @current_user.id, :from => Time.now.beginning_of_month, :to => Time.now.end_of_month,:currency =>params[:currency]}]  )

  		respond_to do |format|	
  			format.xml  { render :action => "movements_by_month.builder", :layout => false }
  		end
	  end
	  
	  def expenditure_by_month_account_type
  	 	@month_data = Movement.data_by_month(:all, :conditions => ["accounts_users.user_id= :id and  movements.movdate BETWEEN :from  AND :to and accounts.type =:account_type and accounts.currency = :currency",{:id => @current_user.id, :from => Time.now.beginning_of_month, :to => Time.now.end_of_month, :account_type => params[:account_type],:currency =>params[:currency]}]  )

  		respond_to do |format|	
  			format.xml  { render :action => "movements_by_month.builder", :layout => false }
  		end
	  end
  	
end
