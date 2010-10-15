class CategoriesController < ApplicationController
  before_filter :require_user 
  add_breadcrumb "Dashboard",:root_path
  def index
    @categories = Category.sharedcats.find(:all,:conditions => ["categories_users.user_id = ?",@current_user.id])
    add_breadcrumb I18n.t('layout.categories.title'), categories_path
    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /categories/1
  # GET /categories/1.xml
  def show
    @category = @current_user.categories.find_by_id(params[:id])
    add_breadcrumb I18n.t('layout.categories.title'), categories_path
    add_breadcrumb I18n.t('layout.categories.name'), category_path(@category.id)
	if @category 
	 
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
    add_breadcrumb I18n.t('layout.categories.title'), categories_path
    add_breadcrumb I18n.t('layout.categories.new'), new_category_path
    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /categories/1/edit
  def edit
    @category = @current_user.categories.find_by_id(params[:id])
	if @category
	  add_breadcrumb I18n.t('layout.categories.title'), categories_path
    add_breadcrumb I18n.t('layout.application.edit'), edit_category_path(@category.id)
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
        @categoriesuser = CategoriesUser.new
        @categoriesuser.user_id = @current_user.id
        @categoriesuser.category_id =  @category.id
        if @categoriesuser.save
        flash[:notice] = I18n.t('layout.categories.notice_message')  %   @category.name
        format.html { redirect_to(categories_path) }
        else
        format.html { render :action => "new" }
        end
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
  
  def update_parent_id
     @category = @current_user.categories.find_by_id(params[:id])
     if @category
        parent_id = params[:parent_id]
        if parent_id == '0' 
          @category.parent_id = nil
        else
          @category.parent_id = parent_id
        end
     		respond_to do |format|
     		  if @category.save
     		    format.json do 		      
     		    render :status => 200, :nothing => true
   		    end
     		  end
     		end
     else
      	redirect_to(categories_path)
     end
   end
  

end
