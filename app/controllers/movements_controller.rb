class MovementsController < ApplicationController
  before_filter(:get_bankaccount)
  # GET /movements
  # GET /movements.xml
  def index
    @movements = @bankaccount.movements.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @movements }
    end
  end

  # GET /movements/1
  # GET /movements/1.xml
  def show
    @movement = @bankaccount.movements.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @movement }
    end
  end

  # GET /movements/new
  # GET /movements/new.xml
  def new
    @movement = @bankaccount.movements.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @movement }
    end
  end

  # GET /movements/1/edit
  def edit
    @movement = @bankaccount.movements.find(params[:id])
  end

  # POST /movements
  # POST /movements.xml
  def create
    @movement = @bankaccount.movements.build(params[:movement])

    respond_to do |format|
      if @movement.save
        flash[:notice] = 'Movement was successfully created.'
        format.html { redirect_to(bankaccount_movements_path(@bankaccount.id)) }
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
    @movement = @bankaccount.movements.find(params[:id])

    respond_to do |format|
      if @movement.update_attributes(params[:movement])
        flash[:notice] = 'Movement was successfully updated.'
        format.html { redirect_to(@movement) }
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
    @movement = @bankaccount.movements.find(params[:id])
    @movement.destroy

    respond_to do |format|
      format.html { redirect_to(bankaccount_movements_path(@bankaccount.id)) }
      format.xml  { head :ok }
    end
  end
  
  private
  def get_bankaccount
  	@bankaccount = Bankaccount.find(params[:bankaccount_id])
  end
end
