class CreditcardaccountsController < ApplicationController
	before_filter :require_user
 
   def index
    @creditcardaccounts = @current_user.creditcardaccounts.find(:all, :select => "accounts.id,accounts.name, accounts.bank,(select sum(amount*mov_type) from movements where movements.account_id = accounts.id) as balance")
    # @creditcardaccounts = @current_user.creditcardaccounts.connection.select_rows('SELECT creditcardaccounts.id,creditcardaccounts.name, creditcardaccounts.bank,(select sum(amount*mov_type) from movements where movements.bankaccount_id =creditcardaccounts.id) as balance FROM creditcardaccounts WHERE (creditcardaccounts.user_id = ?)',@current_user.id)
    # @creditcardaccounts = @current_user.creditcardaccounts.connection.select_rows('SELECT creditcardaccounts.id,creditcardaccounts.name, creditcardaccounts.bank,(select sum(amount*mov_type) from movements where movements.bankaccount_id =creditcardaccounts.id) as balance FROM creditcardaccounts ',:conditions => ['creditcardaccounts.id = ?',@current_user.id])
    @spending_data = Movement.find(:all, :select => "movements.account_id,movements.movdate,(select accounts.name from accounts where accounts.id = movements.account_id) as name,sum(movements.amount) as total", :group => "movements.account_id,movements.movdate",:conditions => ["movements.account_id in (select id from accounts where accounts.user_id= :id and accounts.type = :account_type) and movements.mov_type=-1 and movements.movdate BETWEEN :from  AND :to",{:id => @current_user.id,:account_type => 'Creditcardaccount', :from => Time.now.at_beginning_of_month, :to => Time.now.end_of_month}] )
    
    #@summary =  @current_user.creditcardaccounts.sum("amount * mov_type",:include => :movements, :group => "creditcardaccounts.name")
    #@summary =  @current_user.creditcardaccounts.find)by_sq
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @creditcardaccounts }
    end
  end

  # GET /creditcardaccounts/1
  # GET /creditcardaccounts/1.xml
  def show
    @creditcardaccount = Creditcardaccount.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @creditcardaccount }
    end
  end

  # GET /creditcardaccounts/new
  # GET /creditcardaccounts/new.xml
  def new
    @creditcardaccount = Creditcardaccount.new
    #@bankaccount.user_id = @current_user.id
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @creditcardaccount }
    end
  end

  # GET /creditcardaccounts/1/edit
  def edit
    @creditcardaccount = Creditcardaccount.find(params[:id])
  end

  # POST /creditcardaccounts
  # POST /creditcardaccounts.xml
  def create
    @creditcardaccount = @current_user.creditcardaccounts.build(params[:creditcardaccount])
    #@bankaccount.user_id = @current_user.id
    
    respond_to do |format|
      if @creditcardaccount.save
        flash[:notice] = 'Creditcardaccount was successfully created.'
        format.html { redirect_to(@creditcardaccount) }
        format.xml  { render :xml => @creditcardaccount, :status => :created, :location => @bankaccount }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @creditcardaccount.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /creditcardaccounts/1
  # PUT /creditcardaccounts/1.xml
  def update
    @creditcardaccount = Account.find(params[:id])

    respond_to do |format|
      if @creditcardaccount.update_attributes(params[:creditcardaccount])
        flash[:notice] = 'creditcardaccount was successfully updated.'
        format.html { redirect_to(@creditcardaccount) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @creditcardaccount.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /creditcardaccounts/1
  # DELETE /creditcardaccounts/1.xml
  def destroy
    @creditcardaccount = Account.find(params[:id])
    @creditcardaccount.destroy

    respond_to do |format|
      format.html { redirect_to(creditcardaccounts_url) }
      format.xml  { head :ok }
    end
  end

end
