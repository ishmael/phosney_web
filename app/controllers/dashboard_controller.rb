class DashboardController < ApplicationController
	before_filter :require_user #, :only => [:new, :create,:edit,:update,:index,:destroy]
  
  def index
    @bankaccounts = @current_user.bankaccounts.find_user_bankaccounts(:all, :select => "accounts.id,accounts.name, accounts.bank,(select sum(amount*mov_type) from movements where movements.account_id = accounts.id) as balance, accounts_users.allow_insert,accounts_users.allow_edit,accounts_users.allow_delete,accounts_users.owner")
	  @last5movements = @current_user.movements.find(:all,:limit => 5,:order => "movdate desc")
    @spending_data = Movement.spending_data(:all, :conditions => ["movements.account_id in (select account_id from accounts_users,accounts where accounts_users.user_id= :id and accounts.type =:account_type and accounts_users.account_id = accounts.id) and  movements.movdate BETWEEN :from  AND :to",{:id => @current_user.id,:account_type => 'Bankaccount', :from => Time.now.at_beginning_of_month, :to => Time.now.end_of_month}] )
    @categories = @current_user.categories.find(:all)
	  @tags = @current_user.tags.find(:all)
    respond_to do |format|
      format.html # index.html.erb
	    format.iphone  { render :layout => false }
    end
  end

end
