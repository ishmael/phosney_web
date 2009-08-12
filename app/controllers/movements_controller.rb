class MovementsController < ApplicationController
  before_filter(:get_account)
  before_filter :require_user
  
  
  
  # GET /movements
  # GET /movements.xml
  def index
    @movements = @account.movements.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @movements }
    end
  end

  # GET /movements/1
  # GET /movements/1.xml
  def show
    @movement = @account.movements.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @movement }
    end
  end

  def add
    @movement = Movement.new
    @movement.mov_type = -1
    respond_to do |format|
      format.html # new.html.erb
	  format.iphone  { render :layout => false }
      format.xml  { render :xml => @movement }
    end
  end
  
  # GET /movements/new
  # GET /movements/new.xml
  def new
    @movement = @account.movements.new
    @movement.mov_type = -1
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @movement }
    end
  end

  # GET /movements/1/edit
  def edit
    @movement = @account.movements.find(params[:id])
  end

  # POST /movements
  # POST /movements.xml
  def create
    @movement = @account.movements.build(params[:movement])
    
    respond_to do |format|
      if @movement.save
	    @movement.save_tags(current_user)
        flash[:notice] = 'Movement was successfully created.'
        format.html { redirect_to(polymorphic_path([@account,:movements])) }
        format.xml  { render :xml => @movement, :status => :created, :location => @movement }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @movement.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /movements/1
  # PUT /movements/1.xml
  def update
    @movement = @account.movements.find(params[:id])
	
    respond_to do |format|
      if @movement.update_attributes(params[:movement])
		@movement.save_tags(current_user)
        flash[:notice] = 'Movement was successfully updated.'
        format.html { redirect_to(polymorphic_path([@account,:movements])) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @movement.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /movements/1
  # DELETE /movements/1.xml
  def destroy
    @movement = @account.movements.find(params[:id])
    @movement.destroy

    respond_to do |format|
      format.html { redirect_to(polymorphic_path([@account,:movements])) }
      format.xml  { head :ok }
    end
  end
  
  private
  def get_account
	if not params[:bankaccount_id].nil?
  	@account = Bankaccount.find(params[:bankaccount_id])
	elsif not params[:loanaccount_id].nil?
	@account = Loanaccount.find(params[:loanaccount_id])
	elsif not params[:creditcardaccount_id].nil?
	@account = Creditcardaccount.find(params[:creditcardaccount_id])
	end
  end
  
end
