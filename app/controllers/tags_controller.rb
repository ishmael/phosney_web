class TagsController < ApplicationController
before_filter :require_user
  def index
	@tags = @current_user.tags.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @tags }
    end
  end

    def destroy
    @tags = @current_user.tags.find(params[:id])
    @tags.destroy

    respond_to do |format|
      format.html { redirect_to(tags_url) }
      format.xml  { head :ok }
    end
  end
  
end
