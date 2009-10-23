class BankaccountsController < ApplicationController
  # GET /bankaccounts
  # GET /bankaccounts.xml
  before_filter :require_user #, :only => [:new, :create,:edit,:update,:index,:destroy]
  
  def index
    @bankaccountsdata = @current_user.bankaccounts.find(:all, :select => "accounts.id,accounts.name, accounts.bank,(select sum(amount*mov_type) from movements where movements.account_id = accounts.id) as balance, accounts_users.allow_insert,accounts_users.allow_edit,accounts_users.allow_delete")
    # @bankaccounts = @current_user.bankaccounts.connection.select_rows('SELECT bankaccounts.id,bankaccounts.name, bankaccounts.bank,(select sum(amount*mov_type) from movements where movements.bankaccount_id =bankaccounts.id) as balance FROM bankaccounts WHERE (bankaccounts.user_id = ?)',@current_user.id)
    # @bankaccounts = @current_user.bankaccounts.connection.select_rows('SELECT bankaccounts.id,bankaccounts.name, bankaccounts.bank,(select sum(amount*mov_type) from movements where movements.bankaccount_id =bankaccounts.id) as balance FROM bankaccounts ',:conditions => ['bankaccounts.id = ?',@current_user.id])
    @spending_data = Movement.find(:all, :select => "movements.account_id,movements.movdate,(select accounts.name from accounts where accounts.id = movements.account_id) as name,sum(movements.amount) as total", :group => "movements.account_id,movements.movdate",:conditions => ["movements.account_id in (select account_id from accounts,accounts_users where accounts_users.user_id= :id and accounts.type = :account_type and accounts_users.account_id = accounts.id)  and movements.mov_type=-1 and movements.movdate BETWEEN :from  AND :to",{:id => @current_user.id,:account_type => 'Bankaccount', :from => Time.now.at_beginning_of_month, :to => Time.now.end_of_month}] )
    
    #@summary =  @current_user.bankaccounts.sum("amount * mov_type",:include => :movements, :group => "bankaccounts.name")
    #@summary =  @current_user.bankaccounts.find)by_sq
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
