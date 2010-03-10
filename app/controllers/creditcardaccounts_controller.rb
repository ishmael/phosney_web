class CreditcardaccountsController < ApplicationController
	before_filter :require_user
 
   def index
    @creditcardaccounts = @current_user.creditcardaccounts.find_accounts_with_balance(:all)
    @spending_data = Movement.data_by_month(:all,:conditions => ["movements.mov_type=-1 and accounts_users.user_id= :id and accounts.type =:account_type and  movements.movdate BETWEEN :from  AND :to",{:id => @current_user.id,:account_type => 'Creditcardaccount', :from => Time.now.at_beginning_of_month, :to => Time.now.end_of_month}] )
    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /creditcardaccounts/1
  # GET /creditcardaccounts/1.xml
  def show
    @creditcardaccount = @current_user.creditcardaccounts.find_accounts_with_balance(params[:id])
	if @creditcardaccount 
		respond_to do |format|
		  format.html # show.html.erb
		  #
		end
	else
		redirect_to(dashboard_url)
	end
  end

  # GET /creditcardaccounts/new
  # GET /creditcardaccounts/new.xml
  def new
    @creditcardaccount = Creditcardaccount.new
    #@bankaccount.user_id = @current_user.id
    
    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /creditcardaccounts/1/edit
  def edit
    @creditcardaccount = @current_user.creditcardaccounts.find_by_id(params[:id])
	if @creditcardaccount
		respond_to do |format|
		  format.html 
		  format.iphone  { render :layout => false }
		end
	else
		redirect_to(dashboard_url)
	end
  end

  # POST /creditcardaccounts
  # POST /creditcardaccounts.xml
  def create
    @creditcardaccount = @current_user.creditcardaccounts.build(params[:creditcardaccount])
    #@bankaccount.user_id = @current_user.id
    
    respond_to do |format|
      if @creditcardaccount.save
      	@accountuser = AccountsUser.new
    		@accountuser.user_id = @current_user.id
    		@accountuser.account_id = @creditcardaccount.id
    		@accountuser.allow_insert =  1
    		@accountuser.allow_edit =  1
    		@accountuser.allow_delete =  1
    		@accountuser.owner = 1
    		if @accountuser.save
        flash[:notice] = 'Creditcardaccount was successfully created.'
        format.html { redirect_to([@creditcardaccount,:movements]) }
        else
          format.html { render :action => "new" }
        end
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /creditcardaccounts/1
  # PUT /creditcardaccounts/1.xml
  def update
    @creditcardaccount = @current_user.creditcardaccounts.find(params[:id])
	if @creditcardaccount
		respond_to do |format|
		  if @creditcardaccount.update_attributes(params[:creditcardaccount])
			flash[:notice] = 'creditcardaccount was successfully updated.'
			format.html { redirect_to([@creditcardaccount,:movements]) }
		  else
			format.html { render :action => "edit" }
		  end
		end
	else
		redirect_to(dashboard_url)
	end
  end

  # DELETE /creditcardaccounts/1
  # DELETE /creditcardaccounts/1.xml
  def destroy
    @creditcardaccount = @current_user.creditcardaccounts.find(params[:id])
	if @creditcardaccount
		@creditcardaccount.destroy

		respond_to do |format|
		  format.html { redirect_to(creditcardaccounts_url) }
		end
	else
		redirect_to(dashboard_url)
	end
  end

end
