class BankaccountsController < ApplicationController
  # GET /bankaccounts
  # GET /bankaccounts.xml
  before_filter :require_user #, :only => [:new, :create,:edit,:update,:index,:destroy]
  
  def index
    @bankaccountsdata = @current_user.bankaccounts.find_user_bankaccounts(:all, :select => "accounts.id,accounts.name, accounts.bank,(select sum(amount*mov_type) from movements where movements.account_id = accounts.id and (movements.user_id = accounts_users.user_id  or (movements.private = 0 and movements.user_id <> accounts_users.user_id))) as balance, accounts_users.allow_insert,accounts_users.allow_edit,accounts_users.allow_delete,accounts_users.owner")
    @spending_data = Movement.spending_data(:all, :conditions => ["movements.account_id in (select account_id from accounts_users,accounts where accounts_users.user_id= :id and accounts.type =:account_type and accounts_users.account_id = accounts.id) and  movements.movdate BETWEEN :from  AND :to",{:id => @current_user.id,:account_type => 'Bankaccount', :from => Time.now.at_beginning_of_month, :to => Time.now.end_of_month}] )
    
    respond_to do |format|
      format.html # index.html.erb
	    format.iphone  { render :layout => false }
      format.xml  { render :xml => @bankaccounts }
    end
  end

  # GET /bankaccounts/1
  # GET /bankaccounts/1.xml
  def show
    @bankaccount = @current_user.bankaccounts.find_by_id(params[:id], :select => "accounts.id,accounts.name, accounts.number,accounts.bank,(select sum(amount*mov_type) from movements where movements.account_id = accounts.id) as balance")
	if @bankaccount
		respond_to do |format|
		  format.html # show.html.erb
		  format.iphone { render :layout => false }
		  format.xml  { render :xml => @bankaccount }
		end
	else
		redirect_to(dashboard_url)
	end
  end

  # GET /bankaccounts/new
  # GET /bankaccounts/new.xml
  def new
    @bankaccount = Bankaccount.new
    #@bankaccount.user_id = @current_user.id
    
    respond_to do |format|
      format.html # new.html.erb
	  format.iphone  { render :layout => false }
      format.xml  { render :xml => @bankaccount }
    end
  end

  # GET /bankaccounts/1/edit
  def edit
    @bankaccount = @current_user.bankaccounts.find_by_id(params[:id])
	if @bankaccount
		respond_to do |format|
		  format.html 
		  format.iphone  { render :layout => false }
		  format.xml  { render :xml => @bankaccount }
		end
	else
		redirect_to(dashboard_url)
	end
  end

  # POST /bankaccounts
  # POST /bankaccounts.xml
  def create
    @bankaccount = @current_user.bankaccounts.build(params[:bankaccount])
    #@bankaccount.user_id = @current_user.id
    
    respond_to do |format|
      if @bankaccount.save
        @accountuser = AccountsUser.new
    		@accountuser.user_id = @current_user.id
    		@accountuser.account_id = @bankaccount.id
    		@accountuser.allow_insert =  1
    		@accountuser.allow_edit =  1
    		@accountuser.allow_delete =  1
    		@accountuser.owner = 1
    		if @accountuser.save
          flash[:notice] = 'Bankaccount was successfully created.'
          format.html { redirect_to([@bankaccount,:movements]) }
  		    format.iphone  { redirect_to([@bankaccount,:movements]) }
          format.xml  { render :xml => @bankaccount, :status => :created, :location => @bankaccount }
        else
          format.html { render :action => "new" }
		      format.iphone  { render :action => "new",:layout => false }
          format.xml  { render :xml => @accountuser.errors, :status => :unprocessable_entity }
        end
      else
        format.html { render :action => "new" }
		    format.iphone  { render :action => "new",:layout => false }
        format.xml  { render :xml => @bankaccount.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /bankaccounts/1
  # PUT /bankaccounts/1.xml
  def update
    @bankaccount =@current_user.bankaccounts.find_by_id(params[:id])
	if @bankaccount
		respond_to do |format|
		  if @bankaccount.update_attributes(params[:bankaccount])
			flash[:notice] = 'Bankaccount was successfully updated.'
			format.html { redirect_to([@bankaccount,:movements]) }
			format.iphone  { redirect_to([@bankaccount,:movements])  }
			format.xml  { head :ok }
		  else
			format.html { render :action => "edit" }
			format.iphone  { render :action => "edit", :layout => false }
			format.xml  { render :xml => @bankaccount.errors, :status => :unprocessable_entity }
		  end
		end
	else
		redirect_to(dashboard_url)
	end
  end

  # DELETE /bankaccounts/1
  # DELETE /bankaccounts/1.xml
  def destroy
    @bankaccount = @current_user.bankaccounts.find_by_id(params[:id])
	if @bankaccount	
		@bankaccount.destroy

		respond_to do |format|
		  format.html { redirect_to(bankaccounts_url) }
		  format.iphone  { redirect_to(bankaccounts_url) }
		  format.xml  { head :ok }
		end
	else
		redirect_to(dashboard_url)
	end
  end
end
