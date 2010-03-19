class MovementsController < ApplicationController
  include GeoKit::Mappable
  before_filter(:get_account)
  before_filter :require_user
  
  
  
  # GET /movements
  # GET /movements.xml
  def index
	if @account
		@movements = @account.movements.paginate(:page => params[:page],:conditions => ["movements.user_id =:user_id or  (movements.private =0 and movements.user_id<> :user_id ) ",{:user_id => @current_user.id }],:order => "movdate desc")
		
		@shares = @account.accounts_users.find(:all,:select => "accounts_users.id,accounts_users.allow_insert,accounts_users.allow_edit,accounts_users.allow_delete,(select login from users where users.id = accounts_users.user_id) as login" ,:conditions => ["user_id != ?",@current_user.id])
		respond_to do |format|
		  format.html # index.html.erb
		  format.iphone  { render :layout => false }
		end
	else
	redirect_to(dashboard_url)
	end
  end

  # GET /movements/1
  # GET /movements/1.xml
  def show
	if @account
		@movement = @account.movements.find_by_id(params[:id])
		if (not @movement.lng.blank?) and (not @movement.lat.blank?) 
		@map = GMap.new("map")
		@map.center_zoom_init([@movement.lat, @movement.lng], 18)
		ianazones = GMarker.new([@movement.lat, @movement.lng])
		@map.overlay_init(ianazones)
		
		end
	
		respond_to do |format|
		  format.html # show.html.erb
		  format.iphone  { render :layout => false }
		end
	else
	redirect_to(dashboard_url)
	end
  end

  def quickcreate
		@quick_movement = Movement.new(params[:movement])
		@quick_movement.user_id = @current_user.id
    @account = Account.find @quick_movement.account_id
    @quick_movement.currency = @account.currency
		if @quick_movement.save
			  @quick_movement.save_tags(current_user)
				flash[:notice] = I18n.t('layout.movements.notice_message')  %   [@quick_movement.type_of_movement_desc,@template.format_currency(@quick_movement.amount),@quick_movement.movdate.to_date,@quick_movement.description]
			  redirect_to( request.referer ) 
    else
			  flash[:quickmovement] = @quick_movement
    		redirect_to request.referer 
		end
  end
  
  def quicknew
	 @quick_movement = Movement.new
	 @quick_movement.movdate = Date.today
     @quick_movement.mov_type = -1
     respond_to do |format|
      # format.html # new.html.erb
	    format.iphone  { render :layout => false }
     end
   end
  
  # GET /movements/new
  # GET /movements/new.xml
  def new
    @movement = @account.movements.new
    @movement.mov_type = -1
	  @movement.user_id = @current_user.id
    respond_to do |format|
		  format.html # new.html.erb
	    format.iphone  { render :layout => false }
    end
  end

  # GET /movements/1/edit
  def edit
	if @account
		@movement = @account.movements.find_by_id(params[:id])
		respond_to do |format|
		  format.html # new.html.erb
		  format.iphone  { render :layout => false }
		end
	else
		redirect_to(dashboard_url)
	end
	
  end

  # POST /movements
  # POST /movements.xml
  def create
	if @account
		@movement = @account.movements.build(params[:movement])
		@movement.user_id = @current_user.id
    @movement.currency = @account.currency
		respond_to do |format|
		  if @movement.save
			   @movement.save_tags(current_user)
			flash[:notice] = I18n.t('layout.movements.notice_message')  %   [@movement.type_of_movement_desc,@template.format_currency(@movement.amount),@movement.movdate.to_date,@movement.description]
			format.html { redirect_to(polymorphic_path([@account,:movements])) }
			format.iphone { redirect_to(polymorphic_path([@account,:movements])) }
		  else
			format.html { render :action => "new" }
			format.iphone { render :action => "new", :layout=> false }
		  end
		end
	else
		redirect_to(dashboard_url)
	end
  end

  # PUT /movements/1
  # PUT /movements/1.xml
  def update
	if @account
		@movement = @account.movements.find_by_id(params[:id])
		if @movement.category_id == 0
		  	@movement.category_id = nil
		end		
		@movement.currency = @account.currency
		respond_to do |format|
		  if @movement.update_attributes(params[:movement])
			@movement.save_tags(current_user)
					  flash[:notice] = I18n.t('layout.movements.notice_message')  %   [@movement.type_of_movement_desc,@template.format_currency(@movement.amount),@movement.movdate.to_date,@movement.description]
			format.html { redirect_to(polymorphic_path([@account,:movements])) }
			format.iphone { redirect_to(polymorphic_path([@account,:movements])) }
		  else
			format.html { render :action => "edit" }
			format.iphone { render :action => "edit",:layout => false }
		  end
		end
	else
		redirect_to(dashboard_url)
	end
  end

  # DELETE /movements/1
  # DELETE /movements/1.xml
  def destroy
	if @account
		@movement = @account.movements.find_by_id(params[:id])
		@movement.destroy

		respond_to do |format|
      flash[:notice] = I18n.t('layout.movements.delete_message')  %   [@movement.type_of_movement_desc,@template.format_currency(@movement.amount),@movement.movdate.to_date,@movement.description]
		  format.html { redirect_to(polymorphic_path([@account,:movements])) }
		  format.iphone { redirect_to(polymorphic_path([@account,:movements])) }
		end
	else
		redirect_to(dashboard_url)
	end	
  end
  
  private
  def get_account
    if not params[:bankaccount_id].nil?
    	@account = @current_user.bankaccounts.find_accounts(params[:bankaccount_id])
    elsif not params[:loanaccount_id].nil?
    	@account = @current_user.loanaccounts.find_accounts(params[:loanaccount_id])
    elsif not params[:creditcardaccount_id].nil?
    	@account = @current_user.creditcardaccounts.find_accounts(params[:creditcardaccount_id])
    end
  end
  
end
