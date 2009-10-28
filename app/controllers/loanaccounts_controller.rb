class LoanaccountsController < ApplicationController
	before_filter :require_user
	
  def index
    @loanaccounts = @current_user.loanaccounts.find(:all, :select => "accounts.id,accounts.name, accounts.bank,(select sum(amount*mov_type) from movements where movements.account_id = accounts.id) as balance")
    @spending_data =  Movement.spending_data(:all, :conditions => ["movements.account_id in (select account_id from accounts_users,accounts where accounts_users.user_id= :id and accounts.type =:account_type and accounts_users.account_id = accounts.id) and  movements.movdate BETWEEN :from  AND :to",{:id => @current_user.id,:account_type => 'Loanaccount', :from => Time.now.at_beginning_of_month, :to => Time.now.end_of_month}] )
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @loanaccounts }
    end
  end

  # GET /loanaccounts/1
  # GET /loanaccounts/1.xml
  def show
    @loanaccount = Loanaccount.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @loanaccount }
    end
  end

  # GET /loanaccounts/new
  # GET /loanaccounts/new.xml
  def new
    @loanaccount = Loanaccount.new
    #@loanaccount.user_id = @current_user.id
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @loanaccount }
    end
  end

  # GET /loanaccounts/1/edit
  def edit
    @loanaccount = Loanaccount.find(params[:id])
	respond_to do |format|
	  format.html 
	  format.iphone  { render :layout => false }
	  format.xml  { render :xml => @loanaccount }
    end
  end

  # POST /loanaccounts
  # POST /loanaccounts.xml
  def create
    @loanaccount = @current_user.loanaccounts.build(params[:loanaccount])
    #@loanaccount.user_id = @current_user.id
    
    respond_to do |format|
      if @loanaccount.save
		@accountuser = AccountsUser.new
		@accountuser.user_id = @current_user.id
		@accountuser.account_id = @loanaccount.id
		@accountuser.allow_insert =  1
		@accountuser.allow_edit =  1
		@accountuser.allow_delete =  1
		@accountuser.owner = 1
		if @accountuser.save
			flash[:notice] = 'Loanaccount was successfully created.'
			format.html { redirect_to([@loanaccount,:movements]) }
			format.xml  { render :xml => @loanaccount, :status => :created, :location => @loanaccount }
		else
			format.html { render :action => "new" }
			format.xml  { render :xml => @accountuser.errors, :status => :unprocessable_entity }
		end
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @loanaccount.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /loanaccounts/1
  # PUT /loanaccounts/1.xml
  def update
    @loanaccount = Account.find(params[:id])

    respond_to do |format|
      if @loanaccount.update_attributes(params[:loanaccount])
        flash[:notice] = 'Loanaccount was successfully updated.'
        format.html { redirect_to([@loanaccount,:movements]) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @loanaccount.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /loanaccounts/1
  # DELETE /loanaccounts/1.xml
  def destroy
    @loanaccount = Account.find(params[:id])
    @loanaccount.destroy

    respond_to do |format|
      format.html { redirect_to(bankaccounts_url) }
      format.xml  { head :ok }
    end
  end

end
