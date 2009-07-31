class TagsController < ApplicationController
before_filter :require_user
  def index
	@tags = @current_user.tags.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @tags }
    end
  end

end
