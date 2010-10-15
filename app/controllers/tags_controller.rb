class TagsController < ApplicationController
before_filter :require_user
  add_breadcrumb "Dashboard",:root_path
  def index
		@tags = @current_user.tags.paginate(:page => params[:page])
    add_breadcrumb I18n.t('layout.tags.title'), tags_path
		respond_to do |format|
		  format.html # index.html.erb
		end
	end
	
	def new
		@tag = @current_user.tags.new
    add_breadcrumb I18n.t('layout.tags.title'), tags_path
    add_breadcrumb I18n.t('layout.tags.new'), new_tag_path
		respond_to do |format|
		  format.html # new.html.erb
		end
	end
	
	def create
		@tag = @current_user.tags.build(params[:tag])

		respond_to do |format|
		  if @tag.save
      flash[:notice] = I18n.t('layout.tags.notice_message')  %  @tag.name
			format.html { redirect_to(tags_path) }
		  else
			format.html { render :action => "new" }
		  end
		end
	end

	def edit
		@tag = @current_user.tags.find_by_id(params[:id])
		if @tag
		  add_breadcrumb I18n.t('layout.tags.title'), tags_path
      add_breadcrumb I18n.t('layout.application.edit'), edit_tag_path(@tag.id)
			respond_to do |format|
			  format.html 
			  format.iphone  { render :layout => false }
			end
		else
			redirect_to(tags_path)
		end
	end
	
	def update
		@tag = @current_user.tags.find_by_id(params[:id])
		if @tag
			respond_to do |format|
			  if @tag.update_attributes(params[:tag])
          flash[:notice] = I18n.t('layout.tags.notice_message')  %   @tag.name
				format.html { redirect_to(tags_path) }
			  else
				format.html { render :action => "edit" }
			  end
			end
		else
			redirect_to(tags_path)
		end
	end
	
	
	
    def destroy
		@tag = @current_user.tags.find_by_id(params[:id])
		if @tag
			@tag.destroy

			respond_to do |format|
        flash[:notice] = I18n.t('layout.tags.delete_message')  %   @tag.name
			  format.html { redirect_to(tags_url) }
			end
		else
			redirect_to(tags_path)
		end			
	end
  
end
