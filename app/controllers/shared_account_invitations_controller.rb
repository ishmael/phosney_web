class SharedAccountInvitationsController < ApplicationController
  before_filter :require_user
  
  def new
	
    	@account = @current_user.bankaccounts.find_by_id(params[:bankaccount_id])
	    if @account
     	  @sharedinvitation = @account.shared_account_invitations.new

		    respond_to do |format|
		      
			    format.html # new.html.erb
			    format.iphone  { render :layout => false }
		    end
	    else
		    redirect( dashboard_url)
	    end
  end

  def create
    	@account = @current_user.bankaccounts.find_by_id(params[:bankaccount_id])
	    if @account		
		    @sharedinvitation = @account.shared_account_invitations.build(params[:shared_account_invitation])
		    @sharedinvitation.user_id = @current_user.id
    
    
    	respond_to do |format|
    	  if @sharedinvitation.save
    		@sharedinvitation.send_invitation(@current_user)
    		flash[:notice] = I18n.t('layout.sharedinvitations.notice_message')  %   [@sharedinvitation.recipient_email]
    		format.html { redirect_to(polymorphic_path([@account,:movements])) }
   			format.iphone { redirect_to(polymorphic_path([@account,:movements])) }
    	  else
    		format.html { render :action => "new" }
   			format.iphone { render :action => "new", :layout=> false }
    	  end
		end
  	else
  		redirect( dashboard_url)
  	end
  end

  def destroy
    @account = @current_user.bankaccounts.find_by_id(params[:bankaccount_id])
	  if @account		
      @sharedinvitation = @account.shared_account_invitations.find(params[:id])
      @sharedinvitation.destroy

      respond_to do |format|
    		flash[:notice] = I18n.t('layout.sharedinvitations.delete_message')  %   [@sharedinvitation.recipient_email]        
				format.html { redirect_to(polymorphic_path([@account,:movements])) }
				format.iphone { redirect_to(polymorphic_path([@account,:movements])) }
			end
	  else
		    redirect( dashboard_url)
	  end
  end
  
  def accept
    @sharedinvitation = SharedAccountInvitation.find_by_token(params[:id])
    if @sharedinvitation
      @accountuser = AccountsUser.new
      @accountuser.user_id = @current_user.id
      @accountuser.account_id = @sharedinvitation.account_id
      @accountuser.allow_insert =  @sharedinvitation.allow_insert
      @accountuser.allow_edit =  @sharedinvitation.allow_edit
      @accountuser.allow_delete =  @sharedinvitation.allow_delete
      
        respond_to do |format|
      	  if @accountuser.save
      		@sharedinvitation.destroy
    		flash[:notice] = I18n.t('layout.accountsusers.save_message')
      		format.html { redirect_to(dashboard_url) }
      		format.iphone { redirect_to(dashboard_url) }
      	  end
      	end
    else
      respond_to do |format|
			format.html { redirect_to(dashboard_url) }
			format.iphone { redirect_to(dashboard_url) }
    	end   
    end
    
  end 
end
