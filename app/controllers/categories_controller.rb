class CategoriesController < ApplicationController
  before_filter :require_user 
  
  def index
    @categories = Category.sharedcats.paginate(:conditions => ["categories_users.user_id = ?",@current_user.id],:page => params[:page])

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /categories/1
  # GET /categories/1.xml
  def show
    @category = @current_user.categories.find_by_id(params[:id])

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
        if parent_id == '' 
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
