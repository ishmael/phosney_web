class LoanaccountsController < ApplicationController
	before_filter :require_user
	
  def index
    @loanaccounts = @current_user.loanaccounts.find_accounts_with_balance(:all)
    @spending_data =  Movement.data_by_month(:all, :conditions => ["movements.mov_type=-1 and accounts_users.user_id= :id and accounts.type =:account_type and  movements.movdate BETWEEN :from  AND :to",{:id => @current_user.id,:account_type => 'Loanaccount', :from => Time.now.at_beginning_of_month, :to => Time.now.end_of_month}] )
    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /loanaccounts/1
  # GET /loanaccounts/1.xml
  def show
    @loanaccount = Loanaccount.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /loanaccounts/new
  # GET /loanaccounts/new.xml
  def new
    @loanaccount = Loanaccount.new
    #@loanaccount.user_id = @current_user.id
    
    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /loanaccounts/1/edit
  def edit
    @loanaccount = Loanaccount.find(params[:id])
	respond_to do |format|
	  format.html 
	  format.iphone  { render :layout => false }
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
		else
			format.html { render :action => "new" }
		end
      else
        format.html { render :action => "new" }
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
      else
        format.html { render :action => "edit" }
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
    end
  end

end
