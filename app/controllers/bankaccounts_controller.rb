class BankaccountsController < ApplicationController
  # GET /bankaccounts
  # GET /bankaccounts.xml
  before_filter :require_user #, :only => [:new, :create,:edit,:update,:index,:destroy]
  
  def index
    @bankaccountsdata = @current_user.bankaccounts.find_accounts_with_balance(:all)
    @spending_data = Movement.data_by_month(:all, :conditions => ["movements.mov_type=-1 and accounts_users.user_id= :id and accounts.type =:account_type and  movements.movdate BETWEEN :from  AND :to",{:id => @current_user.id,:account_type => 'Bankaccount', :from => Time.now.at_beginning_of_month, :to => Time.now.end_of_month}] )
    
    respond_to do |format|
		format.html # index.html.erb
	    format.iphone  { render :layout => false }
    end
  end

  # GET /bankaccounts/1
  # GET /bankaccounts/1.xml
  def show
    @bankaccount = @current_user.bankaccounts.find_by_id(params[:id])
	if @bankaccount
		respond_to do |format|
		  format.html # show.html.erb
		  format.iphone { render :layout => false }
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
    end
  end

  # GET /bankaccounts/1/edit
  def edit
    @bankaccount = @current_user.bankaccounts.find_by_id(params[:id])
	if @bankaccount
		respond_to do |format|
		  format.html 
		  format.iphone  { render :layout => false }
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
        else
			format.html { render :action => "new" }
		    format.iphone  { render :action => "new",:layout => false }

        end
      else
			format.html { render :action => "new" }
		    format.iphone  { render :action => "new",:layout => false }
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
		  else
			format.html { render :action => "edit" }
			format.iphone  { render :action => "edit", :layout => false }
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
		end
	else
		redirect_to(dashboard_url)
	end
  end
end
