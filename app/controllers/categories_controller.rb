class CategoriesController < ApplicationController
  before_filter :require_user 
  
  def index
    @categories = @current_user.categories.find(:all,:order => "name asc")

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @categories }
    end
  end

  # GET /categories/1
  # GET /categories/1.xml
  def show
    @categories = @current_user.categories.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @categories }
    end
  end

  # GET /categories/new
  # GET /categories/new.xml
  def new
    @category = @current_user.categories.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @category }
    end
  end

  # GET /categories/1/edit
  def edit
    @category = @current_user.categories.find(params[:id])
  end

  # POST /categories
  # POST /categories.xml
  def create
    @category = @current_user.categories.build(params[:category])

    respond_to do |format|
      if @category.save
        flash[:notice] = 'Category was successfully created.'
        format.html { redirect_to(categories_path) }
        format.xml  { render :xml => @category, :status => :created, :location => @category }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @category.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /categories/1
  # PUT /categories/1.xml
  def update
    @category = @current_user.categories.find(params[:id])

    respond_to do |format|
      if @category.update_attributes(params[:category])
        flash[:notice] = 'Category was successfully updated.'
        format.html { redirect_to(categories_path) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @category.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.xml
  def destroy
    @category = @current_user.categories.find(params[:id])
    @category.destroy

    respond_to do |format|
      format.html { redirect_to(categories_path) }
      format.xml  { head :ok }
    end
  end

end
