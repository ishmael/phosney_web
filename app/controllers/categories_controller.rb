class CategoriesController < ApplicationController
  before_filter :require_user 
  
  def index
    @categories = @current_user.categories.find(:all,:order => "name asc")

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /categories/1
  # GET /categories/1.xml
  def show
    @categories = @current_user.categories.find_by_id(params[:id])
	if @categories
		respond_to do |format|
		  format.html # show.html.erb
		end
	else
		redirect_to(categories_path)
	end
  end

  # GET /categories/new
  # GET /categories/new.xml
  def new
    @category = @current_user.categories.new
    
    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /categories/1/edit
  def edit
    @category = @current_user.categories.find_by_id(params[:id])
	if @category
		respond_to do |format|
		  format.html 
		  format.iphone  { render :layout => false }
		end
	else
		redirect_to(categories_path)
	end
  end

  # POST /categories
  # POST /categories.xml
  def create
    @category = @current_user.categories.build(params[:category])

    respond_to do |format|
      if @category.save
        flash[:notice] = I18n.t('layout.categories.notice_message')  %   @category.name
        format.html { redirect_to(categories_path) }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /categories/1
  # PUT /categories/1.xml
  def update
    @category = @current_user.categories.find_by_id(params[:id])
	if @category
		respond_to do |format|
		  if @category.update_attributes(params[:category])
			flash[:notice] = I18n.t('layout.categories.notice_message')  %   @category.name
			format.html { redirect_to(categories_path) }
		  else
			format.html { render :action => "edit" }
		  end
		end
	else
		redirect_to(categories_path)
	end
  end

  # DELETE /categories/1
  # DELETE /categories/1.xml
  def destroy
    @category = @current_user.categories.find_by_id(params[:id])
	if @category
		@category.destroy

		respond_to do |format|
		  flash[:notice] = I18n.t('layout.categories.delete_message')  %   @category.name
		  format.html { redirect_to(categories_path) }
		end
	else
		redirect_to(categories_path)
	end
  end

end
