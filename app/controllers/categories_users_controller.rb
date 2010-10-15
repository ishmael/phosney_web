class CategoriesUsersController < ApplicationController
  before_filter :require_user 
  add_breadcrumb "Dashboard",:root_path
  def new
	
    	@category = @current_user.categories.find_by_id(params[:category_id])
	    if @category
     	  @categoryusers = @category.categories_users.new
        add_breadcrumb I18n.t('layout.categories.title'), categories_path
        add_breadcrumb I18n.t('layout.categories.name'), category_path(@category.id)
        add_breadcrumb I18n.t('layout.application.share'), new_polymorphic_path([@category,:categories_user])             	  
		    respond_to do |format|    
			    format.html # new.html.erb
		    end
	    else
		    redirect_to( dashboard_url)
	    end
  end

  def create
    	@category = @current_user.categories.find_by_id(params[:category_id])
	    if @category		
		    @categoryusers = @category.categories_users.build(params[:categories_user])
		    @categoryusers.category_id = @category.id
    
    
    	respond_to do |format|
    	  if @categoryusers.save
    		flash[:notice] = I18n.t('layout.categoriesusers.notice_message')  %   [@category.name,User.find(@categoryusers.user_id).login]
    		format.html { redirect_to(category_path(@category)) }
   			format.iphone { redirect_to(category_path(@category)) }
    	  else
    		format.html { render :action => "new" }
   			format.iphone { render :action => "new", :layout=> false }
    	  end
		end
  	else
  		redirect_to( dashboard_url)
  	end
  end

  def destroy
    @category = @current_user.categories.find_by_id(params[:category_id])
    
    if @category		  
      @categoryusers = @category.categories_users.find_by_id(params[:id])
      @categoryusers.destroy
      respond_to do |format|
    		flash[:notice] = I18n.t('layout.categoriesusers.delete_message')  %   [@category.name,User.find(@categoryusers.user_id).login]        
				format.html { redirect_to(category_path(@category)) }
				format.iphone { redirect_to(category_path(@category)) }
			end
	  else
		    redirect_to( dashboard_url)
	  end
  end
end
